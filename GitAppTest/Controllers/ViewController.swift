//
//  ViewController.swift
//  GitAppTest
//
//  Created by Danilo Requena on 04/08/20.
//

import UIKit

class ViewController: UIViewController {
    
    var gistsData: [Gists] = []
    var gistDataModel: GistDataModel?
    var page = 1
    var label = UILabel()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Não há favoritos cadastrados!"
        label.textAlignment = .center
        setupTableView()
        fetchData()
        configureNavigationBar(largeTitleColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), backgoundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), tintColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), title: "Gists", preferredLargeTitle: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func fetchData() {
        guard let url = URL(string: "\(Constants.baseURL)\(page)") else { return }
        print(url)
        
        Request.loadAll { (items) in
            if let items = items {
                self.gistsData += items
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        } onError: { (error) in
            print(error)
        }
    }
    
    func saveGistFavorite(indexPath: IndexPath) {
        let data = gistsData[indexPath.row]
        gistDataModel = GistDataModel(context: context)
        gistDataModel?.ownerName = data.owner.ownerName
        gistDataModel?.ownerImage = data.owner.avatarURL
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.separatorStyle = .none
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let controller = segue.destination as? DetailViewController else { return }
        controller.gist = gistsData[tableView.indexPathForSelectedRow!.row]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundView = gistsData.count == 0 ? label : nil
        return gistsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellName, for: indexPath) as! MainTableViewCell
        let data = gistsData[indexPath.row]
        cell.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.layer.borderWidth = 4
        cell.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cell.layer.cornerRadius = 16
        cell.setupCell(data: data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let save = UIContextualAction(style: .normal, title: "save") { (action, view, actionPerformed: (Bool) -> ()) in
            self.saveGistFavorite(indexPath: indexPath)
            actionPerformed(true)
        }
        save.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        save.image = UIImage(systemName: "star")
        
        let config  = UISwipeActionsConfiguration(actions: [save])
        config.performsFirstActionWithFullSwipe = false
        
        return config
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == gistsData.count - 10 {
            page += 1
            fetchData()
            print("Carregando mais")
        }
     }
}


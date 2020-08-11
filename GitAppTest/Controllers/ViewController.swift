//
//  ViewController.swift
//  GitAppTest
//
//  Created by Danilo Requena on 04/08/20.
//

import UIKit

class ViewController: UIViewController {
    
    var gistsData: [Gists] = []
    var searchGists = [Gists]()
    var searching = false
    var gistDataModel: GistDataModel?
    var page = 1
    var label = UILabel()
    let searchController = UISearchController(searchResultsController: nil)

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Carregando..."
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        setupTableView()
        fetchData()
        setupSearch()
        configureNavigationBar(largeTitleColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), backgoundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), tintColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), title: "Gists", preferredLargeTitle: true)
        tableView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
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
        gistDataModel?.ownerDescription = data.gistsDatumDescription
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func setupSearch() {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = .white
        searchController.searchBar.barTintColor = .white
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
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
        if searching{
            return searchGists.count
        } else {
            return gistsData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellName, for: indexPath) as! MainTableViewCell
        if searching {
            let data = searchGists[indexPath.row]
            cell.setupCell(data: data)
        } else {
            let data = gistsData[indexPath.row]
            cell.setupCell(data: data)
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let save = UIContextualAction(style: .normal, title: "save") { (action, view, actionPerformed: (Bool) -> ()) in
            let alert = UIAlertController(title: "", message: "Adicionado aos favoritos", preferredStyle: .alert)
            let action = UIAlertAction(title: "continuar", style: .cancel, handler: nil)
            alert.addAction(action)
            alert.view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            self.present(alert, animated: true, completion: nil)
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
        if indexPath.row == gistsData.count - 2 {
            page += 1
            fetchData()
            print("Carregando mais")
            
            cell.alpha = 0
            UIView.animate(withDuration: 1.0) {
                cell.alpha = 1.0
            }
        }
     }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension ViewController: UISearchResultsUpdating ,UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchGists = gistsData.filter({$0.owner.ownerName.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        tableView.reloadData()
    }
    
}


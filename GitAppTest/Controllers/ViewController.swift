//
//  ViewController.swift
//  GitAppTest
//
//  Created by Danilo Requena on 04/08/20.
//

import UIKit

class ViewController: UIViewController {
    
    var gistsData: [Gists] = []
    var page = 1

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchData()
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

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(MainTableViewCell.loadNib(), forCellReuseIdentifier: MainTableViewCell.identifier())
        tableView.rowHeight = 150
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gistsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier(), for: indexPath) as! MainTableViewCell
        let data = gistsData[indexPath.row]
        cell.layer.cornerRadius = 10
        cell.setupCell(data: data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}


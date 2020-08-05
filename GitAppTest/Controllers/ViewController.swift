//
//  ViewController.swift
//  GitAppTest
//
//  Created by Danilo Requena on 04/08/20.
//

import UIKit

class ViewController: UIViewController {
    
    var githubData = [GithubData]()
    let api = Interactor<Items>()
    var page = 1

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
        setupTableView()
        fetchData()
    }
    
    func fetchData() {
        guard let url = URL(string: "\(Constants.basePath)\(page)") else { return }
        
        api.fetchModel(url: url) { (items) in
            if let itemsData = items {
                for data in itemsData.items {
                    self.githubData.append(data)
                }
            }
            self.tableView.reloadData()
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(MainTableViewCell.loadNib(), forCellReuseIdentifier: MainTableViewCell.identifier())
        tableView.tableFooterView = UIView()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return githubData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier(), for: indexPath) as! MainTableViewCell
        let data = githubData[indexPath.row]
        cell.setupCell(data: data)
        
        return cell
    }
    
    
}


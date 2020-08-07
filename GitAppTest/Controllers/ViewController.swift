//
//  ViewController.swift
//  GitAppTest
//
//  Created by Danilo Requena on 04/08/20.
//

import UIKit

class ViewController: UIViewController {
    
//    var gistsData = [GistsData]()
    var gistsData: [GistsData] = []
    let api = Interactor<Items>()
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
        
//        api.fetchModel(url: url) { (items) in
//            if let itemsData = items {
//
//                print("passou aqui")
//                for data in itemsData.items {
//                    self.gistsData.append(data)
//                }
//            }
//            self.tableView.reloadData()
//        }
        
        Request.loadAll { (items) in
            self.gistsData += items
        } onError: { (error) in
            print(error)
        }
        tableView.reloadData()

    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(MainTableViewCell.loadNib(), forCellReuseIdentifier: MainTableViewCell.identifier())
        tableView.rowHeight = 150
        tableView.tableFooterView = UIView()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gistsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier(), for: indexPath) as! MainTableViewCell
        let data = gistsData[indexPath.row]
        cell.setupCell(data: data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}


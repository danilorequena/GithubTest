//
//  FavoriteViewController.swift
//  GitAppTest
//
//  Created by Danilo Requena on 08/08/20.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController {

    var manager = GistsFavoritesManager.shared
    var fetchedResultsController: NSFetchedResultsController<GistDataModel>!
    var gistsData: [GistDataModel]!
    var label = UILabel()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Não há favoritos cadastrados!"
        label.textAlignment = .center
        setupTableView()
        loadGists()
        configureNavigationBar(largeTitleColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), backgoundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), tintColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), title: "Favorites", preferredLargeTitle: true)

    }
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func loadGists() {
        let fetchRequest: NSFetchRequest<GistDataModel> = GistDataModel.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "ownerName", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        do {
        try fetchedResultsController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deteteFavorite(index: Int, context: NSManagedObjectContext) {
        let gist = gistsData[index]
        context.delete(gist)
        do {
            try context.save()
            gistsData.remove(at: index)
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = fetchedResultsController.fetchedObjects?.count ?? 0
        tableView.backgroundView = count == 0 ? label : nil
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! FavoriteTableViewCell
        guard let gist = fetchedResultsController.fetchedObjects?[indexPath.row] else { return cell }
        cell.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.layer.borderWidth = 4
        cell.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cell.layer.cornerRadius = 16
        cell.setupCell(with: gist)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let favorite = self.fetchedResultsController.fetchedObjects?[indexPath.row] else { return }
            self.context.delete(favorite)
        }
    }
}

extension FavoriteViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
            case .delete:
                if let indexPath = indexPath {
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }                
            default:
                tableView.reloadData()
        }
    }
}

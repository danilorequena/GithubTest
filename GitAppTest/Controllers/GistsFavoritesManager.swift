//
//  GistsFavoritesManager.swift
//  GitAppTest
//
//  Created by Danilo Requena on 09/08/20.
//

import CoreData

class GistsFavoritesManager {
    static let shared = GistsFavoritesManager()
    var gistsData: [GistDataModel] = []
    
    func saveGistFavorite(with context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<GistDataModel> = GistDataModel.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "ownerName", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            gistsData = try context.fetch(fetchRequest)
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
    private init() {
        
    }
    
}

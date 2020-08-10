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
    
//    func saveGistFavorite(indexPath: IndexPath, with context: NSManagedObjectContext, dataModel: GistDataModel) {
//        var data = gistsData[indexPath.row]
//        data = GistDataModel(context: context)
//        dataModel.ownerName = data.owner.ownerName
//        do {
//            try context.save()
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
    
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

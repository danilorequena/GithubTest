//
//  Interactor.swift
//  GitAppTest
//
//  Created by Danilo Requena on 05/08/20.
//

import Foundation
import Alamofire

class Interactor<S> where S: Decodable {
    
    typealias Model = S
    
    func fetchModel(url: URL, completion: @escaping (Model?) -> Void) {
        
        AF.request(url).responseJSON { (response) in
            if let error = response.error {
                debugPrint(error.localizedDescription)
                completion(nil)
            }
            
            guard let data = response.data else { return completion(nil) }
            do {
                let json = try JSONDecoder().decode(Model.self, from: data)
                completion(json)
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
}

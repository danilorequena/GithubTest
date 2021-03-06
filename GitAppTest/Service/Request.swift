//
//  Request.swift
//  GitAppTest
//
//  Created by Danilo Requena on 04/08/20.
//

import Foundation

enum GitHubError {
    case url
    case taskError(error: Error)
    case noResponse
    case noData
    case responseStatusCode(code: Int)
    case invalidJSON
}

class Request {
    private static let session = URLSession.shared
    
    class func loadGists(urlString: String, onComplete: @escaping ([Gists]?) -> Void, onError: @escaping (GitHubError) -> Void) {
        guard let url = URL(string: urlString) else {
            onError(.url)
            return
        }
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if error == nil {
                guard let response = response as? HTTPURLResponse else {
                    onError(.noResponse)
                    print("NoResponse")
                    return
                }
//                if response.statusCode != 500 {
                    guard let data = data else { return }
                    do {
                        let decoder = JSONDecoder()
                        let repositories = try decoder.decode([Gists].self, from: data)
                        onComplete(repositories)
                    } catch let jsonErr as NSError {
                        onError(.invalidJSON)
                        print(jsonErr.debugDescription)
                    }
//                } else {
//                    onError(.responseStatusCode(code: response.statusCode))
//                    print("Erro de servidor")
//                }
            } else {
                onError(.taskError(error: error!))
                print("Algo deu errado")
            }
        }
        dataTask.resume()
    }
}

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
    
    class func loadAll(onComplete: @escaping ([GistsData]) -> Void, onError: @escaping (GitHubError) -> Void) {
        guard let url = URL(string: Constants.baseURL) else {
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
                if response.statusCode == 200 {
                    guard let data = data else { return }
                    do {
                        let repositories = try JSONDecoder().decode([GistsData].self, from: data)
                        onComplete(repositories)
                    } catch let jsonErr as NSError {
                        onError(.invalidJSON)
                        print(jsonErr.debugDescription)
                    }
                } else {
                    onError(.responseStatusCode(code: response.statusCode))
                    print("Erro de servidor")
                }
            } else {
                onError(.taskError(error: error!))
                print("Algo deu errado")
            }
        }
        dataTask.resume()
    }
}

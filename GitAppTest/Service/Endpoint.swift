//
//  Endpoint.swift
//  GitAppTest
//
//  Created by Danilo Requena on 04/08/20.
//

import Foundation

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
    
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.github.com"
        urlComponents.path = path
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }
    
    static func search(page: Int) -> Endpoint {
        Endpoint(path: "/search/repositories",
                 queryItems: [
                    URLQueryItem(name: "q", value: "language:swift"),
                    URLQueryItem(name: "sort", value: "stars"),
                    URLQueryItem(name: "per_page", value: "30"),
                    URLQueryItem(name: "page", value: "\(page)")
            ])
    }
    
    static func pullRequests(author: String, repository: String) -> Endpoint {
        return Endpoint(path: "/repos/\(author)/\(repository)/pulls", queryItems: [URLQueryItem]())
    }
}

//
//  GitHub.swift
//  GitAppTest
//
//  Created by Danilo Requena on 04/08/20.
//

import Foundation


//struct Items: Decodable {
//    let items : [GithubData]
//}

struct GithubData: Decodable {
    let name: String
    let description: String
    let stars: Int64
    let forks: Int64
    let owner: Owner
    
    enum CodingKeys: String, CodingKey {
        case name
        case description
        case stars = "stargazers_count"
        case forks = "forks_count"
        case owner
    }
}

//struct Owner: Decodable {
//    let authorName: String
//    let avatarUrl: String
//
//    enum CodingKeys: String, CodingKey {
//        case authorName = "login"
//        case avatarUrl = "avatar_url"
//    }
//}

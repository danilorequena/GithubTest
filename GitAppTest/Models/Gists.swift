//
//  Gists.swift
//  GitAppTest
//
//  Created by Danilo Requena on 06/08/20.
//

import Foundation

//struct Items: Codable {
//    let items: [GistsData]
//}

// MARK: - GistsData
struct GistsData: Codable {
    let files: Files
    let description: String?
    let owner: Owner

    enum CodingKeys: String, CodingKey {
        case files
        case description
        case owner
    }
}

 //MARK: - Files
struct Files: Codable {
    let websiteCommand: WebsiteCommand?

    enum CodingKeys: String, CodingKey {
        case websiteCommand
    }
}

// MARK: - WebsiteCommand
struct WebsiteCommand: Codable {
    let filename, type: String?
}

// MARK: - Owner
struct Owner: Codable {
    let login: String
    let avatarURL: String

    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
    }
}

typealias Items = [GistsData]

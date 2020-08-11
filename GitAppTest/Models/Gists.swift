//
//  Gists.swift
//  GitAppTest
//
//  Created by Danilo Requena on 06/08/20.
//

import Foundation


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let gistsData = try? newJSONDecoder().decode(GistsData.self, from: jsonData)

import Foundation

// MARK: - GistsDatum
struct Gists: Codable {
  
    let files: [String: File]
    let gistsDatumDescription: String?
    let owner: Owner

    enum CodingKeys: String, CodingKey {
        case files
        case gistsDatumDescription = "description"
        case owner
    }
}

// MARK: - File
struct File: Codable {
    let type: String

    enum CodingKeys: String, CodingKey {
        case type
    }
}

// MARK: - Owner
struct Owner: Codable {
    let ownerName: String
    let avatarURL: String?
    let url: String

    enum CodingKeys: String, CodingKey {
        case ownerName = "login"
        case avatarURL = "avatar_url"
        case url = "html_url"
    }
}

typealias GistsData = [Gists]

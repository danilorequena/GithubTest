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
    let avatarURL: String

    enum CodingKeys: String, CodingKey {
        case ownerName = "login"
        case avatarURL = "avatar_url"
    }
}

typealias GistsData = [Gists]

// MARK: - Encode/decode helpers

//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}




////struct Items: Codable {
////    let items: [GistsData]
////}
//
//// MARK: - GistsData
//struct GistsData: Codable {
//    let files: Files
//    let description: String?
//    let owner: Owner
//
//    enum CodingKeys: String, CodingKey {
//        case files
//        case description
//        case owner
//    }
//}
//
// //MARK: - Files
//struct Files: Codable {
//    let websiteCommand: WebsiteCommand?
//
//    enum CodingKeys: String, CodingKey {
//        case websiteCommand
//    }
//}
//
//// MARK: - WebsiteCommand
//struct WebsiteCommand: Codable {
//    let filename, type: String?
//}
//
//// MARK: - Owner
//struct Owner: Codable {
//    let login: String
//    let avatarURL: String
//
//    enum CodingKeys: String, CodingKey {
//        case login
//        case avatarURL = "avatar_url"
//    }
//}
//
//typealias Items = [GistsData]

//
//  NetworkError.swift
//  GitAppTest
//
//  Created by Danilo Requena on 06/08/20.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case unauthorized
    case forbidden
    case notFound
    case mappingError
    case emptyResponseDataError
    case unknownError
}

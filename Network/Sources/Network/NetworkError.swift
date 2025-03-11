//
//  NetworkError.swift
//  Network
//
//  Created by Ahmed on 10/03/2025.
//

import Foundation

public enum NetworkError: Error, CustomDebugStringConvertible {
    case badURL
    case decoding
    case statusCode 
    case failure(_ error: URLError)
    
    public var debugDescription: String {
        switch self {
        case .badURL: "Bad URL 🚧"
        case .decoding: "Decoding 📝"
        case .statusCode: "Status Code 🗿"
        case .failure: "Failure ❌"
        }
    }
}

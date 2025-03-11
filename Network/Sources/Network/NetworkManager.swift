//
//  NetworkManager.swift
//  Network
//
//  Created by Ahmed on 10/03/2025.
//

import Foundation

public protocol NetworkManager {
    func execute<T: Decodable>(request: URLRequest) async throws -> T
}

public final class DefaultNetworkManager: NetworkManager {
    
    // MARK: Private Properties
    
    private let urlSession: URLSession
    private let jsonDecoder: JSONDecoder
    
    // MARK: Constructor
    
    public init(
        urlSession: URLSession = .shared,
        jsonDecoder: JSONDecoder
    ) {
        self.urlSession = urlSession
        self.jsonDecoder = jsonDecoder
    }
    
    // MARK: Public Interface
    
    public func execute<T: Decodable>(request: URLRequest) async throws -> T {
        guard let url = request.url else {
            throw NetworkError.badURL
        }
        
        do {
            let (data, response) = try await urlSession.data(from: url)
            
            if isValidResponse(response) {
                return try jsonDecoder.decode(T.self, from: data)
            }
            else {
                throw NetworkError.statusCode
            }
        }
        catch is DecodingError {
            throw NetworkError.decoding
        }
        catch let error as URLError {
            throw NetworkError.failure(error)
        }
    }
    
    private func isValidResponse(_ response: URLResponse) -> Bool {
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            return false
        }
        
        return true
    }
}

//
//  File.swift
//  Data
//
//  Created by Ahmed on 07/03/2025.
//

import Domain
import Foundation
import Network

struct Constants {
    static let endpoint: String = "https://rickandmortyapi.com/api/character"
    static let queryPageKey: String = "page"
}

public class DefaultCharactersRepository: CharactersRepository {
    
    /// ``External Dependency``
    ///
    private let networkManager: NetworkManager
    
    // MARK: Constructor
    
    public init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    // MARK: Public Interface
    
    public func fetchCharacters(at page: Int) async throws -> [Domain.Character] {
        do {
            /// The logic related to building a request can be separated into a `RequestBuilder` type for separation of concerns.
            /// But out of simplicity of the feature, I'm keeping it straight-forward.
            ///
            guard let url = URL(string: Constants.endpoint)?.appending(
                queryItems: [URLQueryItem(name: Constants.queryPageKey, value: page.description)]
            ) else {
                throw NetworkError.badURL
            }
            
            let request = URLRequest(url: url)
            
            let result: CharacterWrapperDTO = try await networkManager.execute(request: request)
            return result.results.map { $0.toDomain }
        }
        catch {
            print(error.localizedDescription)
            throw error
        }
    }
}

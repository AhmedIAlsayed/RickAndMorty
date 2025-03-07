//
//  File.swift
//  Data
//
//  Created by Ahmed on 07/03/2025.
//

import Domain
import Foundation

public class DefaultCharactersRepository: CharactersRepository {
    
    // TODO: Add a remote service or a network layer.
    // If a network layer directly, then explain.
    // If not, then add a remote service and explain also the dependency graph and the flow of control.
    //
    public init() { }
    
    public func fetchCharacters(at page: Int) async throws -> [Domain.Character] {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else { return [] }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            return try JSONDecoder()
                .decode(Wrapper.self, from: data)
                .results
                .map { $0.toDomain }
        }
    }
}

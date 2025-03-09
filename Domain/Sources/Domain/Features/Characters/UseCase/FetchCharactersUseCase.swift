//
//  FetchCharactersUseCase.swift
//  Domain
//
//  Created by Ahmed on 07/03/2025.
//

import Foundation

public protocol FetchCharactersUseCase {
    func execute(at page: Int, filter: String?) async throws -> [Character]
}

public final class DefaultFetchCharactersUseCase: FetchCharactersUseCase {
    
    private let charactersRepository: CharactersRepository
    
    public init(charactersRepository: CharactersRepository) {
        self.charactersRepository = charactersRepository
    }
    
    public func execute(at page: Int, filter: String? = nil) async throws -> [Character] {
        try await charactersRepository.fetchCharacters(at: page, filter: filter)
    }
}

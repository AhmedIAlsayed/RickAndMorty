//
//  FetchCharactersUseCase.swift
//  Domain
//
//  Created by Ahmed on 07/03/2025.
//

import Foundation

public protocol FetchCharactersUseCase {
    func execute(for page: Int) async throws -> [Character]
}

public final class DefaultFetchCharactersUseCase: FetchCharactersUseCase {
    
    private let charactersRepository: CharactersRepository
    
    public init(charactersRepository: CharactersRepository) {
        self.charactersRepository = charactersRepository
    }
    
    public func execute(for page: Int) async throws -> [Character] {
        try await charactersRepository.fetchCharacters(for: page)
    }
}

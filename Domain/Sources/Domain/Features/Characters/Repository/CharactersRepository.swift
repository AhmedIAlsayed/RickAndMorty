//
//  File.swift
//  Domain
//
//  Created by Ahmed on 07/03/2025.
//

import Foundation

public protocol CharactersRepository {
    func fetchCharacters(at page: Int) async throws -> [Character]
}

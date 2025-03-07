//
//  CharacterDTO.swift
//  Data
//
//  Created by Ahmed on 07/03/2025.
//

import Foundation
import Domain

public struct Wrapper: Decodable {
    public let results: [CharacterDTO]
}

public struct CharacterDTO: Decodable {
    
    /// `id` is the only non-optional returned type.
    /// For any reason, if it would not return, we should not mask that error by providing a default value.
    ///
    private let id: Int
    private let name: String?
    private let status: String?
    private let species: String?
    private let image: String?
    
    public init(
        id: Int,
        name: String?,
        status: String?,
        species: String?,
        image: String?
    ) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.image = image
    }
    
    public var toDomain: Domain.Character {
        return Character(
            id: id,
            imageURLString: image ?? "",
            title: name ?? "",
            subtitle: species ?? ""
        )
    }
}

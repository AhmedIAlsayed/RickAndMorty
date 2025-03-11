//
//  CharacterDTO.swift
//  Data
//
//  Created by Ahmed on 07/03/2025.
//

import Foundation
import Domain

public struct CharacterWrapperDTO: Decodable {
    public let results: [CharacterDTO]
}

public struct CharacterDTO: Decodable {
    
    /// `id` is the only non-optional returned type.
    /// For any reason, if it would not return, we should not mask that error by providing a default value.
    ///
    private let id: Int
    private let name: String?
    private let status: String?
    private let type: String?
    private let species: String?
    private let gender: String?
    private let image: String?
    private let location: LocationDTO?
    
    public init(
        id: Int,
        name: String?,
        status: String?,
        type: String?,
        species: String?,
        gender: String?,
        image: String?,
        location: LocationDTO?
    ) {
        self.id = id
        self.name = name
        self.status = status
        self.type = type
        self.species = species
        self.gender = gender
        self.image = image
        self.location = location
    }
    
    public var toDomain: Domain.Character {
        return Character(
            id: id,
            imageURLString: image ?? "",
            title: name ?? "",
            subtitle: species ?? "",
            status: status ?? "",
            species: species ?? "",
            gender: gender ?? "",
            location: location?.name ?? ""
        )
    }
}

public struct LocationDTO: Decodable {
    public let name: String
}

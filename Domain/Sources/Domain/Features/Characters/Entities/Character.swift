//
//  Character.swift
//  Domain
//
//  Created by Ahmed on 07/03/2025.
//

import Foundation

public struct Character {
    public let id: Int
    public let imageURLString: String
    public let title: String
    public let subtitle: String
    public let status: String
    public let species: String
    public let gender: String
    public let location: String
    
    public init(
        id: Int,
        imageURLString: String,
        title: String,
        subtitle: String,
        status: String,
        species: String,
        gender: String,
        location: String
    ) {
        self.id = id
        self.imageURLString = imageURLString
        self.title = title
        self.subtitle = subtitle
        self.status = status
        self.species = species
        self.gender = gender
        self.location = location
    }
}

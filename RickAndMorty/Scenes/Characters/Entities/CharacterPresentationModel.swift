//
//  CharactersPresentationModel.swift
//  RickAndMorty
//
//  Created by Ahmed on 07/03/2025.
//

import Domain

struct CharacterPresentationModel {
    let id: Int
    let imageURLString: String
    let title: String
    let subtitle: String
    let status: String
    let species: String
    let gender: String
    let location: String
    
    /// The value is set here so it becomes a constant and `does not mutate between renders`
    /// and would result in flickering in the `backgroundColor`.
    ///
    let backgroundColor = randomColor()
    
    init(_ character: Domain.Character) {
        self.id = character.id
        self.imageURLString = character.imageURLString
        self.title = character.title
        self.subtitle = character.subtitle
        self.status = character.status
        self.species = character.species
        self.gender = character.gender
        self.location = character.location
    }
}

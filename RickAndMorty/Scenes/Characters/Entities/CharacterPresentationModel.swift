//
//  CharactersPresentationModel.swift
//  RickAndMorty
//
//  Created by Ahmed on 07/03/2025.
//

import Domain

struct CharacterPresentationModel {
    let id: String
    let imageURLString: String
    let title: String
    let subtitle: String
    
    init(_ character: Domain.Character) {
        self.id = character.id
        self.imageURLString = character.imageURLString
        self.title = character.title
        self.subtitle = character.subtitle
    }
}

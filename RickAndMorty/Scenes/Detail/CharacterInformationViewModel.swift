//
//  CharacterInformationViewModel.swift
//  RickAndMorty
//
//  Created by Ahmed on 09/03/2025.
//

import Foundation
import Combine

final class CharacterInformationViewModel: ObservableObject {
    
    let character: CharacterPresentationModel
    
    init(character: CharacterPresentationModel) {
        self.character = character
    }
}

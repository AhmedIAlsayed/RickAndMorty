//
//  CharactersFactory.swift
//  RickAndMorty
//
//  Created by Ahmed on 06/03/2025.
//

import UIKit

protocol CharactersSceneFactory {
    func createCharactersScene() -> CharactersViewController
}

final class DefaultCharactersSceneFactory: CharactersSceneFactory {
    
    func createCharactersScene() -> CharactersViewController {
        return CharactersViewController()
    }
}

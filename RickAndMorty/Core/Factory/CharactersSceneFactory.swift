//
//  CharactersFactory.swift
//  RickAndMorty
//
//  Created by Ahmed on 06/03/2025.
//

import UIKit
import Domain
import Data

protocol CharactersSceneFactory {
    func createCharactersScene() -> CharactersViewController
}

final class DefaultCharactersSceneFactory: CharactersSceneFactory {
    
    // MARK: Public Interface
    
    func createCharactersScene() -> CharactersViewController {
        let presenter = createCharactersPresenter()
        let viewController = CharactersViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
    
    // MARK: Public Implementations
    
    private func createCharactersPresenter() -> CharactersPresenter {
        let useCase = createFetchCharactersUseCase()
        return DefaultCharactersPresenter(fetchCharactersUseCase: useCase)
    }
    
    private func createFetchCharactersUseCase() -> FetchCharactersUseCase {
        let repository = createCharactersRepository()
        return DefaultFetchCharactersUseCase(charactersRepository: repository)
    }
    
    private func createCharactersRepository() -> CharactersRepository {
        return DefaultCharactersRepository()
    }
}

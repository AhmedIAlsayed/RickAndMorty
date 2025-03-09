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
    func createCharactersScene(with coordinator: Coordinator) -> CharactersViewController
}

final class DefaultCharactersSceneFactory: CharactersSceneFactory {
    
    // MARK: Public Interface
    
    func createCharactersScene(with coordinator: Coordinator) -> CharactersViewController {
        let presenter = createCharactersPresenter(with: coordinator)
        let viewController = CharactersViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
    
    // MARK: Public Implementations
    
    private func createCharactersPresenter(with coordinator: Coordinator) -> CharactersPresenter {
        let useCase = createFetchCharactersUseCase()
        return DefaultCharactersPresenter(
            fetchCharactersUseCase: useCase,
            coordinator: coordinator
        )
    }
    
    private func createFetchCharactersUseCase() -> FetchCharactersUseCase {
        let repository = createCharactersRepository()
        return DefaultFetchCharactersUseCase(charactersRepository: repository)
    }
    
    private func createCharactersRepository() -> CharactersRepository {
        return DefaultCharactersRepository()
    }
}

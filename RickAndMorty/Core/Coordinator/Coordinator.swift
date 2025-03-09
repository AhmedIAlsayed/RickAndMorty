//
//  Coordinator.swift
//  RickAndMorty
//
//  Created by Ahmed on 06/03/2025.
//

import UIKit

protocol Coordinator {
    func start()
    func navigateToDetails(with character: CharacterPresentationModel)
}

/// The `Coordinator` creates and manages the lifetime of the views and their flow.
///
final class DefaultCoordinator: Coordinator {
    
    private let charactersSceneFactory: CharactersSceneFactory
    private let window: UIWindow
    private var navigationController: UINavigationController?
    
    init(charactersSceneFactory: CharactersSceneFactory) {
        self.charactersSceneFactory = charactersSceneFactory
        self.window = UIWindow(frame: UIScreen.main.bounds)
    }
    
    func start() {
        let charactersViewController = charactersSceneFactory.createCharactersScene(with: self)
        navigationController = UINavigationController(rootViewController: charactersViewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func navigateToDetails(with character: CharacterPresentationModel) {
        // TODO: !!
        // 1. Have the DetailsFactory create the SwiftUI scene with it's dependencies and push it to the
        // navigation stack.
        // 2. Remove the DetailsViewController since it's useless.
        // 
        // let hostingController = UIHostingController<DetailsView>(rootViewController: )
        navigationController?.pushViewController(DetailsViewController(character: character), animated: true)
    }
}

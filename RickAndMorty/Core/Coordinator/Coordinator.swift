//
//  Coordinator.swift
//  RickAndMorty
//
//  Created by Ahmed on 06/03/2025.
//

import UIKit

protocol Coordinator {
    func start()
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
        let charactersViewController = charactersSceneFactory.createCharactersScene()
        navigationController = UINavigationController(rootViewController: charactersViewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

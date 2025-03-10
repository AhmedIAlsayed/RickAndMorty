//
//  Coordinator.swift
//  RickAndMorty
//
//  Created by Ahmed on 06/03/2025.
//

import UIKit
import SwiftUI

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
        let characterInformationViewModel = CharacterInformationViewModel(character: character)
        let characterInformationView = CharacterInformationView(viewModel: characterInformationViewModel)
        
        let characterInformationViewController = UIHostingController.init(rootView: characterInformationView)
        characterInformationViewController.modalPresentationStyle = .popover
        navigationController?.present(characterInformationViewController, animated: true)
    }
}

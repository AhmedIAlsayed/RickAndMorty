//
//  AppDelegate.swift
//  RickAndMorty
//
//  Created by Ahmed on 06/03/2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var coordinator: Coordinator?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        let charactersFactory: CharactersSceneFactory = DefaultCharactersSceneFactory()
        coordinator = DefaultCoordinator(charactersSceneFactory: charactersFactory)
        coordinator?.start()
        
        return true
    }
}


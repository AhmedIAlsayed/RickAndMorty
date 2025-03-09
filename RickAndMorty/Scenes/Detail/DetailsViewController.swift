//
//  DetailsViewController.swift
//  RickAndMorty
//
//  Created by Ahmed on 06/03/2025.
//

import UIKit

class DetailsViewController: UIViewController {

    private let character: CharacterPresentationModel
    
    init(character: CharacterPresentationModel) {
        self.character = character
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = character.title
        view.backgroundColor = .orange
    }
}

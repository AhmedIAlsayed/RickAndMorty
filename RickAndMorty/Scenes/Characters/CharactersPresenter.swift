//
//  CharactersPresenter.swift
//  RickAndMorty
//
//  Created by Ahmed on 07/03/2025.
//

import Foundation

protocol CharactersPresenter: AnyObject {
    var view: CharacterView? { get set }
    var title: String { get }
    var characters: [CharacterPresentationModel] { get }
    
    func viewDidLoad()
    func configure(view: CharacterItemView, at row: Int)
}

final class DefaultCharactersPresenter: CharactersPresenter {
    
    // MARK: Private Properties
    
    private(set) var characters: [CharacterPresentationModel] = [] {
        didSet { reload() }
    }
    
    // MARK: Public Properties
    
    weak var view: CharacterView?
    
    var title: String {
        return "Characters"
    }
    
    // MARK: Constructor
    
    init() {
        
    }
    
    // MARK: Public Interfaces
    
    func viewDidLoad() {
        fetchCharacters()
    }
    
    func configure(view: CharacterItemView, at row: Int) {
        view.configure(with: characters[row])
    }
    
    // MARK: Private Implementations
    
    private func fetchCharacters() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.characters.append(contentsOf: [
                CharacterPresentationModel(id: "", imageURLString: "", title: "Adlskfds", subtitle: "ryt"),
                CharacterPresentationModel(id: "", imageURLString: "", title: "fsdfdsf", subtitle: "iuy"),
                CharacterPresentationModel(id: "", imageURLString: "", title: "kjhhj", subtitle: "dsfsdfsd"),
                CharacterPresentationModel(id: "", imageURLString: "", title: "khjjh", subtitle: "ryueyt"),
                CharacterPresentationModel(id: "", imageURLString: "", title: "hdgffgh", subtitle: "urteu"),
                CharacterPresentationModel(id: "", imageURLString: "", title: "hfghfg", subtitle: "gasdg"),
                CharacterPresentationModel(id: "", imageURLString: "", title: "rwerw", subtitle: "fsgd"),
                CharacterPresentationModel(id: "", imageURLString: "", title: "cbvcv", subtitle: "fdsfds"),
                CharacterPresentationModel(id: "", imageURLString: "", title: "645gf", subtitle: "gg"),
                CharacterPresentationModel(id: "", imageURLString: "", title: "rujer", subtitle: "jgh"),
                CharacterPresentationModel(id: "", imageURLString: "", title: "hgfdfg", subtitle: "gweg"),
                CharacterPresentationModel(id: "", imageURLString: "", title: "iyuiy", subtitle: "hfghgf"),
                CharacterPresentationModel(id: "", imageURLString: "", title: "KLDFS", subtitle: "sdg"),
                CharacterPresentationModel(id: "", imageURLString: "", title: "gfhfg", subtitle: "DV"),
                CharacterPresentationModel(id: "", imageURLString: "", title: "OIU", subtitle: "oiu"),
                CharacterPresentationModel(id: "", imageURLString: "", title: "tykr", subtitle: "LUI"),
            ])
        })
    }
    
    private func reload() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            
            self.view?.reload()
        }
    }
}

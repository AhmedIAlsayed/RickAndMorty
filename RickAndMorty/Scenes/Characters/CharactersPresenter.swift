//
//  CharactersPresenter.swift
//  RickAndMorty
//
//  Created by Ahmed on 07/03/2025.
//

import Foundation
import Domain

protocol CharactersPresenter: AnyObject {
    var view: CharacterView? { get set }
    var title: String { get }
    var characters: [CharacterPresentationModel] { get }
    
    func viewDidLoad()
    func configure(view: CharacterItemView, at row: Int)
}

final class DefaultCharactersPresenter: CharactersPresenter {
    
    // MARK: Private Properties
    
    private let fetchCharactersUseCase: FetchCharactersUseCase
    
    /// An integer that captures the state of the `currently fetched page` from our endpoint.
    ///
    private var currentPage: Int = 1
    
    private(set) var characters: [CharacterPresentationModel] = [] {
        didSet { reload() }
    }
    
    // MARK: Public Properties
    
    weak var view: CharacterView?
    
    /// This title is statically typed, it would usually read from a localized data-source.
    /// i.e: `R.localized` or the String assets.
    ///
    var title: String {
        return "Characters"
    }
    
    // MARK: Constructor
    
    init(fetchCharactersUseCase: FetchCharactersUseCase) {
        self.fetchCharactersUseCase = fetchCharactersUseCase
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
        Task(priority: .background) {
            do {
                characters = try await fetchCharactersUseCase
                    .execute(for: currentPage)
                    .map(CharacterPresentationModel.init)
            }
            catch {
                print(error)
            }
        }
    }
    
    private func reload() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            
            self.view?.reload()
        }
    }
}

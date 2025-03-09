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
    var filtersCount: Int { get }
    
    func viewDidLoad()
    func configure(view: CharacterItemView, at row: Int)
    func configure(view: FilterItemView, at item: Int)
    func title(at item: Int) -> String
    func didSelectItem(at index: Int)
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
    /// i.e: `R.localized` or the `String assets`.
    ///
    var title: String {
        return "Characters"
    }
    
    /// I've made the assumption that the list of filtering options are `static`.
    /// Usually this sort of ambiguity would be sorted out during the feature's requirement's alignment and we would ask any clarifying questions.
    /// For the sake of demonstration, I'll keep them a fixed number.
    ///
    var filtersCount: Int {
        return FilterState.allCases.count
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
    
    func configure(view: FilterItemView, at item: Int) {
        view.configure(with: FilterState.allCases[item].rawValue)
    }
    
    func title(at item: Int) -> String {
        return FilterState.allCases[item].rawValue
    }
    
    func didSelectItem(at index: Int) {
        let filter = FilterState.allCases[index].rawValue
        fetchCharacters(filter: filter)
    }
    
    // MARK: Private Implementations
    
    private func fetchCharacters(filter: String? = nil) {
        Task(priority: .background) {
            do {
                characters = try await fetchCharactersUseCase
                    .execute(at: currentPage, filter: filter)
                    .map(CharacterPresentationModel.init)
                
                currentPage += 1
            }
            catch {
                // TODO: Handle error!!! ❌
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

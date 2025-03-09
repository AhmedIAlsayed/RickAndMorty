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
    var filteredCharacters: [CharacterPresentationModel] { get }
    var filtersCount: Int { get }
    
    func viewDidLoad()
    func configure(view: CharacterItemView, at row: Int)
    func configure(view: FilterItemView, at item: Int)
    func title(at item: Int) -> String
    func prefetch()
    func didSelectItem(at index: Int)
}

final class DefaultCharactersPresenter: CharactersPresenter {
    
    // MARK: Private Properties
    
    private let fetchCharactersUseCase: FetchCharactersUseCase
    
    /// An integer that captures the state of the `currently fetched page` from our endpoint.
    ///
    private var currentPage: Int = 1
    
    private var isLoading: Bool = false
    
    /// This will be considered the `in-memory cache` for when any fetching operation occurs.
    ///
    private var inMemoryCharacters: [CharacterPresentationModel] = [] {
        didSet { setFilteredCharacters() }
    }
    
    private var filterState: FilterState? { didSet { reload() } }
    
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
    
    /// This will be the array of characters that will be consumed and used to render the `UI`
    ///
    private(set) var filteredCharacters: [CharacterPresentationModel] = [] {
        didSet { reload() }
    }
    
    // MARK: Constructor
    
    init(fetchCharactersUseCase: FetchCharactersUseCase) {
        self.fetchCharactersUseCase = fetchCharactersUseCase
    }
    
    // MARK: Public Interfaces
    
    func viewDidLoad() {
        fetchCharacters()
    }
    
    /// `CharacterTableView` Cell's configuration.
    ///
    func configure(view: CharacterItemView, at row: Int) {
        view.configure(with: filteredCharacters[row])
    }
    
    /// `FilterCollectionView` Cells configuration.
    ///
    func configure(view: FilterItemView, at item: Int) {
        let title = FilterState.allCases[item].rawValue
        let isSelected = filterState?.rawValue == title ? true : false
        view.configure(with: title, isSelected: isSelected)
    }
    
    func title(at item: Int) -> String {
        return FilterState.allCases[item].rawValue
    }
    
    func didSelectItem(at index: Int) {
        let selectedFilter = FilterState.allCases[index]
        filterState = selectedFilter
        applyFilter(selectedFilter)
    }
    
    func prefetch() {
        fetchCharacters()
    }
    
    // MARK: Private Implementations
    
    private func fetchCharacters() {
        Task(priority: .background) {
            do {
                isLoading = true
                
                // TODO: Remove print at finish.
                print("Fetching page number: \(currentPage)")
                
                let characters = try await fetchCharactersUseCase
                    .execute(at: currentPage)
                    .map(CharacterPresentationModel.init)
                
                isLoading = false
                // TODO:
                // Add has next page to make sure that the page does have a next to make sure of redundant api calls.
                currentPage += 1
                
                inMemoryCharacters.append(contentsOf: characters)
            }
            catch {
                isLoading = false
                // TODO: Handle error!!! ❌
                print(error)
            }
        }
    }
    
    private func setFilteredCharacters() {
        if let filterState {
            applyFilter(filterState)
        }
        else {
            filteredCharacters = inMemoryCharacters
        }
    }
    
    private func applyFilter(_ filter: FilterState) {
        filteredCharacters = inMemoryCharacters.filter {
            $0.subtitle.lowercased().contains(filter.rawValue.lowercased())
        }
    }
    
    private func reload() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            
            self.view?.reload()
        }
    }
}

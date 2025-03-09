//
//  CharactersPresenter.swift
//  RickAndMorty
//
//  Created by Ahmed on 07/03/2025.
//

import Foundation

protocol CharactersPresenter: AnyObject {
    var view: CharacterView? { get set }
    
    var numberOfCharacters: Int { get }
    var numberOfFilters: Int { get }
    var shouldDisplayEmptyState: Bool { get }
    
    func viewDidLoad()
    func title(at item: Int) -> String
    func configure(view: CharacterItemView, at row: Int)
    func configure(view: FilterItemView, at item: Int)
    func prefetchRows(at indexPaths: [IndexPath])
    func didSelectItem(at index: Int)
}

//
//  CharactersConstants.swift
//  RickAndMorty
//
//  Created by Ahmed on 09/03/2025.
//

import Foundation

struct CharactersConstants {
    
    static let title: String = "Characters"
    
    /// ``Character TableView Cell``
    ///
    static let characterCellReuseIdentifier: String = String(describing: CharacterTableViewCell.self)
    static let paginationThreshold: Int = 2
    
    /// ``Section Header View``
    ///
    static let headerReuseIdentifier: String = String(describing: FiltersHeaderView.self)
    static let heightForHeader: CGFloat = 48.0

    /// ``Filter CollectionView Cell``
    ///
    static let filterCellReuseIdentifier: String = String(describing: FilterCollectionViewCell.self)
    static let filterCellPadding: CGFloat = 16.0
    static let fontSize: CGFloat = 16.0
}

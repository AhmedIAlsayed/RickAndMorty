//
//  FiltersHeaderView.swift
//  RickAndMorty
//
//  Created by Ahmed on 07/03/2025.
//

import UIKit

final class FiltersHeaderView: UITableViewHeaderFooterView {
    
    // MARK: Private Properties
    
    private var filtersCollectionView: UICollectionView!
    
    // MARK: Constructors
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public Interface

    typealias UICollectionViewDataSourceDelegate = (
        UICollectionViewDataSource & UICollectionViewDelegateFlowLayout
    )
    
    func setCollectionViewDataSourceDelegate(
        dataSourceDelegate: UICollectionViewDataSourceDelegate,
        forSection section: Int
    ) {
        filtersCollectionView.delegate = dataSourceDelegate
        filtersCollectionView.dataSource = dataSourceDelegate
    }
    
    // MARK: Private Implementations
        
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        
        /// Leading padding and insets.
        ///
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 8, bottom: 0, right: 0)
        
        filtersCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        filtersCollectionView.showsHorizontalScrollIndicator = false
        filtersCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        filtersCollectionView.register(
            FilterCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: FilterCollectionViewCell.self)
        )
        
        contentView.addSubview(filtersCollectionView)
        
        NSLayoutConstraint.activate([
            filtersCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            filtersCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            filtersCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            filtersCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}

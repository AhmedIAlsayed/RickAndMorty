//
//  CharactersViewController.swift
//  RickAndMorty
//
//  Created by Ahmed on 06/03/2025.
//

import UIKit

protocol CharacterView: AnyObject {
    func reload()
}

final class CharactersViewController: UIViewController, CharacterView {
    
    /// Safe to `force-unwrap` the TableView since it's `guaranteed` to have it's value set and not nullified.
    ///
    private var charactersTableView: UITableView!
    
    /// ``External Dependencies``
    ///
    private let presenter: CharactersPresenter
    
    // MARK: Constructors
    
    init(presenter: CharactersPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifetime Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        configureNavigationBar()
        configureCharactersTableView()
    }
    
    // MARK: Public Interfaces
    
    func reload() {
        /// This method is already dispatched from the presenter's end on the `Main-Thread`.
        ///
        charactersTableView.reloadData()
    }
    
    // MARK: Private Implementations
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = CharactersConstants.title
        
        if let navigationBar = navigationController?.navigationBar {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.shadowColor = .clear
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
        }
    }
    
    private func configureCharactersTableView() {
        charactersTableView = UITableView()
        
        charactersTableView.dataSource = self
        charactersTableView.delegate = self
        charactersTableView.prefetchDataSource = self
        charactersTableView.separatorStyle = .none
        charactersTableView.translatesAutoresizingMaskIntoConstraints = false
        
        charactersTableView.register(
            CharacterTableViewCell.self,
            forCellReuseIdentifier: CharactersConstants.characterCellReuseIdentifier
        )
        
        charactersTableView.register(
            FiltersHeaderView.self,
            forHeaderFooterViewReuseIdentifier: CharactersConstants.headerReuseIdentifier
        )
        
        view.addSubview(charactersTableView)
        
        NSLayoutConstraint.activate([
            charactersTableView.topAnchor.constraint(equalTo: view.topAnchor),
            charactersTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            charactersTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            charactersTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: TableView DataSource

extension CharactersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfCharacters
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if presenter.shouldDisplayEmptyState {
            return emptyCell()
        }
        else {
            return characterCell(tableView, at: indexPath)
        }
    }
    
    private func emptyCell() -> EmptyTableViewCell {
        return EmptyTableViewCell()
    }
    
    private func characterCell(_ tableView: UITableView, at indexPath: IndexPath) -> CharacterTableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CharactersConstants.characterCellReuseIdentifier,
            for: indexPath
        ) as! CharacterTableViewCell
        
        /// Method injecting the reference of an ImageLoader, since we can't opt for
        /// constructor injection in cells due it's dequeuing behaviour.
        ///
        cell.setImageLoader()
        
        presenter.configure(view: cell, at: indexPath.row)
        
        return cell
    }
}

// MARK: TableView Delegate

extension CharactersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectItem(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: CharactersConstants.headerReuseIdentifier
        ) as! FiltersHeaderView
        
        headerView.setCollectionViewDataSourceDelegate(
            dataSourceDelegate: self,
            forSection: section
        )
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CharactersConstants.heightForHeader
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: TableView Prefetch DataSource

extension CharactersViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        presenter.prefetchRows(at: indexPaths)
    }
}

// MARK: CollectionView DataSource

extension CharactersViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfFilters
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CharactersConstants.filterCellReuseIdentifier,
            for: indexPath
        ) as! FilterCollectionViewCell
        
        presenter.configure(view: cell, at: indexPath.item)
        
        return cell
    }
}

// MARK: CollectionView Delegate

extension CharactersViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        presenter.didSelectFilter(at: indexPath.item)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        /// This calculation allows for setting the cell's width based on
        /// the `intrinsic width of the text` to be displayed plus it's `padding`.
        ///
        let title = presenter.title(at: indexPath.item)
        let font = UIFont.systemFont(ofSize: CharactersConstants.fontSize)
        let textWidth = title.size(withAttributes: [.font: font]).width
        
        /// Multiplied by `2` since the padding is applied in both the leading and trailing edges.
        ///
        let cellWidth = textWidth + (CharactersConstants.filterCellPadding * 2)
        return CGSize(width: cellWidth, height: CharactersConstants.heightForHeader)
    }
}

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
    
    // MARK: Private Properties
    
    private struct Constants {
        static let cellReuseIdentifier: String = "CharactersTableViewCell"
    }
    
    /// Safe to `force-unwrap` the TableView since it's `guaranteed` to have it's value set and not nullified.
    ///
    private var charactersTableView: UITableView!
    
    private let presenter: CharactersPresenter
    
    // MARK: Constructor
    
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
        navigationItem.title = presenter.title
    }
    
    private func configureCharactersTableView() {
        charactersTableView = UITableView()
        charactersTableView.dataSource = self
        
        charactersTableView.register(
            CharacterTableViewCell.self,
            forCellReuseIdentifier: Constants.cellReuseIdentifier
        )
        
        charactersTableView.separatorStyle = .none
        charactersTableView.translatesAutoresizingMaskIntoConstraints = false
        
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
        presenter.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.cellReuseIdentifier,
            for: indexPath
        ) as! CharacterTableViewCell
        
        presenter.configure(view: cell, at: indexPath.row)
        
        return cell
    }
}

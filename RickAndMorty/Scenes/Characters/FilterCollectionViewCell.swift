//
//  FilterCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Ahmed on 07/03/2025.
//

import UIKit

protocol FilterItemView {
    func configure(with title: String)
}

class FilterCollectionViewCell: UICollectionViewCell, FilterItemView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: Constructor
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifetime Events
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureInterfaceElements()
    }
    
    // MARK: Public Interface
    
    func configure(with title: String) {
        titleLabel.text = title
    }
    
    // MARK: Private Implementations
    
    private func configureInterfaceElements() {
        containerView.layer.borderColor = UIColor.systemIndigo.withAlphaComponent(0.3).cgColor
        containerView.layer.borderWidth = 2
        containerView.layer.cornerRadius = containerView.frame.height / 2
        containerView.clipsToBounds = true
    }
    
    private func layoutConstraints() {
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        
        /// `ContainerView`'s constraints.
        ///
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        /// `TitleLabel`'s constraints.
        ///
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
        ])
    }
}

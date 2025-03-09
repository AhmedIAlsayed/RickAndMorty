//
//  CharacterTableViewCell.swift
//  RickAndMorty
//
//  Created by Ahmed on 07/03/2025.
//

import UIKit

protocol CharacterItemView {
    func configure(with character: CharacterPresentationModel)
}

final class CharacterTableViewCell: UITableViewCell, CharacterItemView {
    
    // MARK: Private Properties
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = randomColor()
        return view
    }()
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .cyan
        imageView.layer.cornerRadius = 16
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .gray.withAlphaComponent(0.8)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .top
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: Constructor
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        layoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public Interface
    
    func configure(with character: CharacterPresentationModel) {
        titleLabel.text = character.title
        subtitleLabel.text = character.subtitle
    }
    
    // MARK: Private Properties
    
    private func layoutConstraints() {
        configureContainerViewLayout()
        configureContentStackViewLayout()
        configureLabelsStackViewLayout()
        configureCharacterImageViewLayout()
    }
    
    /// The `Container Stack View`
    /// Is the `top most view` within the hierarchy and which holds the `Content Stack`
    ///
    private func configureContainerViewLayout() {
        addSubview(containerView)
        
        NSLayoutConstraint.activate([
            // containerView.heightAnchor.constraint(equalToConstant: 120),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    /// The `Content Stack View`
    /// Is the 2nd top most view, which is a horizontal stack view holding the `Character ImageView` and the `two labels`.
    ///
    private func configureContentStackViewLayout() {
        /// `Parent` relationship setting.
        ///
        containerView.addSubview(contentStackView)
        
        /// `Children` relationship setting.
        ///
        contentStackView.addArrangedSubview(characterImageView)
        contentStackView.addArrangedSubview(labelsStackView)
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            contentStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            contentStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            contentStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8)
        ])
    }

    private func configureLabelsStackViewLayout() {
        labelsStackView.addArrangedSubview(titleLabel)
        labelsStackView.addArrangedSubview(subtitleLabel)
    }
    
    private func configureCharacterImageViewLayout() {
        NSLayoutConstraint.activate([
            characterImageView.heightAnchor.constraint(equalToConstant: 60),
            characterImageView.heightAnchor.constraint(equalTo: characterImageView.widthAnchor, multiplier: 1)
        ])
    }
}

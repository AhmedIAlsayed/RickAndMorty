//
//  CharacterTableViewCell.swift
//  RickAndMorty
//
//  Created by Ahmed on 07/03/2025.
//

import UIKit
import Network

protocol CharacterItemView {
    func configure(with character: CharacterPresentationModel)
}

final class CharacterTableViewCell: UITableViewCell, CharacterItemView {
    
    // MARK: Private Properties
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .cyan.withAlphaComponent(0.05)
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
    
    /// Captures the reference of the currently running `URLSessionDataTask`'s `URL` string.
    /// This reference will be used to call cancel on the specific request.
    ///
    private var currentlyRunningTask: String?
    
    /// `Optional` since this dependency is injected later-on during the lifetime of this cell.
    ///
    private var imageLoader: ImageLoader?
    
    // MARK: Constructor
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifetime Events
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        characterImageView.image = nil
        
        /// Make sure to `cancel` the request first before nullifying it's reference within the cell.
        ///
        if let imageLoader, let currentlyRunningTask {
            imageLoader.cancel(request: currentlyRunningTask)
        }
        
        currentlyRunningTask = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureInterfaceElements()
    }
    
    // MARK: Public Interface
    
    /// Injecting the reference of an `ImageLoader` instead of statically locating it's reference.
    ///
    func setImageLoader(_ loader: ImageLoader = DefaultImageLoader.shared) {
        self.imageLoader = loader
    }
    
    func configure(with character: CharacterPresentationModel) {
        containerView.backgroundColor = character.backgroundColor
        titleLabel.text = character.title
        subtitleLabel.text = character.subtitle
        
        if let imageLoader, !character.imageURLString.isEmpty {
            currentlyRunningTask = character.imageURLString
            
            imageLoader.load(
                image: character.imageURLString,
                completion: { [weak self] image in
                    guard let self else { return }
                    
                    if let image {
                        /// The image is returned on the `Main Thread`,
                        /// so it's safe to consume it directly here without taking any concurrency concerns.
                        ///
                        self.characterImageView.image = image
                    }
                }
            )
        }
    }
    
    // MARK: Private Properties
    
    private func configureInterfaceElements() {
        characterImageView.layer.cornerRadius = 12
        characterImageView.clipsToBounds = true
    }
    
    private func layoutConstraints() {
        selectionStyle = .none
        
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

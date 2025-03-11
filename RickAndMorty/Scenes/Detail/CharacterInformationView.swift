//
//  CharacterInformationView.swift
//  RickAndMorty
//
//  Created by Ahmed on 09/03/2025.
//

import SwiftUI
import Network

struct CharacterInformationView: View {
    
    /// ``Internal State``
    ///
    @State private var image: UIImage?
    
    /// ``External Dependencies``
    ///
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var viewModel: CharacterInformationViewModel
    private let imageLoader: ImageLoader
    
    // MARK: Constructor
    
    init(
        viewModel: CharacterInformationViewModel,
        imageLoader: ImageLoader = DefaultImageLoader.shared
    ) {
        self.viewModel = viewModel
        self.imageLoader = imageLoader
    }
    
    // MARK: Public View
    
    var body: some View {
        VStack(spacing: 20) {
            userImageView
                .overlay(alignment: .topLeading) { backButton.padding() }
                .foregroundColor(Color.gray.opacity(0.2))
                .cornerRadius(30)
            
            infoVStack
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .onAppear { loadImage() }
    }
    
    // MARK: Private Views
    
    private var userImageView: some View {
        if let image {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(height: 400)
                .clipped()
        }
        else {
            Image(systemName: "photo")
                .resizable()
                .scaledToFill()
                .frame(height: 400)
                .clipped()
        }
    }
    
    private var backButton: some View {
        Button(action: dismissView) {
            Image(systemName: "arrow.left")
                .foregroundColor(.white)
                .padding(10)
                .background(Color.white.opacity(0.2))
                .clipShape(Circle())
        }
    }
    
    private var statusTextView: some View {
        Text(viewModel.character.status)
            .font(.caption)
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 6)
            .frame(height: 30)
            .background(Color.cyan)
            .clipShape(RoundedRectangle(cornerRadius: 15))
    }
    
    private var titleTextView: some View {
        Text(viewModel.character.title)
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.black)
    }
    
    private var subtitleTextView: some View {
        Text("\(viewModel.character.subtitle) • \(viewModel.character.gender)")
            .font(.subheadline)
            .foregroundColor(.gray)
    }
    
    private var locationTextView: some View {
        Text("\(CharactersConstants.location) : \(viewModel.character.location)")
            .font(.subheadline)
            .foregroundColor(.black)
    }
    
    /// ``Container Stack Views``
    ///
    private var infoVStack: some View {
        VStack(alignment: .leading, spacing: 8) {
            topSectionHStack
            locationTextView
        }
    }
    
    private var topSectionHStack: some View {
        HStack {
            titleStackView
            
            Spacer()
            
            statusTextView
        }
    }
    
    private var titleStackView: some View {
        VStack(alignment: .leading, spacing: 2) {
            titleTextView
            subtitleTextView
        }
    }
    
    // MARK: Private Implementations
    
    private func dismissView() {
        presentationMode.wrappedValue.dismiss()
    }
    
    private func loadImage() {
        imageLoader.load(image: viewModel.character.imageURLString, completion: { _image in
            if let _image { DispatchQueue.main.async { image = _image } }
        })
    }
}

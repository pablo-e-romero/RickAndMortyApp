//
//  DependenciesContainer.swift
//  RickAndMortyKit
//
//  Created by Pablo Romero on 12/04/2026.
//

import SwiftUI
import Domain

public struct DependenciesContainer<PictureDetailView: View> {
    private let pictureDetailViewProvider: (URL?, String) -> PictureDetailView
    private let charactersListViewModelProvider: (@escaping (Character) -> Void) -> CharactersListViewModel
    
    public init(
        pictureDetailViewProvider: @escaping (URL?, String) -> PictureDetailView,
        charactersListViewModelProvider: @escaping (@escaping (Character) -> Void) -> CharactersListViewModel
    ) {
        self.pictureDetailViewProvider = pictureDetailViewProvider
        self.charactersListViewModelProvider = charactersListViewModelProvider
    }
    
    func makePictureDetailView(url: URL?, accessibilityLabel: String) -> PictureDetailView {
        pictureDetailViewProvider(url, accessibilityLabel)
    }
    
    func makeCharactersListViewModel(
        selectedCharacter: @escaping (Domain.Character) -> Void
    ) -> CharactersListViewModel {
        charactersListViewModelProvider(selectedCharacter)
    }
}

//
//  DependenciesContainer.swift
//  RickAndMortyApp
//
//  Created by Pablo Romero on 29/3/26.
//

import Foundation
import CharactersCore
import Networking

import CharactersFeature
import PictureFeature

final class DependenciesContainer {
    let charactersRepository: CharactersRepository

    init(charactersRepository: CharactersRepository) {
        self.charactersRepository = charactersRepository
    }
}

extension DependenciesContainer {
    static var live: DependenciesContainer {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        let apiService = APIService(
            baseURL: RicketAndMortyAPIConstants.baseURL,
            decoder: decoder
        )

        return .init(
            charactersRepository: CharactersRepository(service: apiService)
        )
    }
}

extension CharactersFeature.DependenciesContainer where PictureDetailView == PictureFeature.PictureDetailView {
    static func make(with dependenciesContainer: DependenciesContainer) -> Self {
        .init(
            pictureDetailViewProvider: { url, accessibilityLabel in
                PictureDetailView(
                    url: url,
                    accessibilityLabel: accessibilityLabel
                )
            },
            charactersListViewModelProvider: { selectedCharacter in
                CharactersListViewModel(
                    repository: dependenciesContainer.charactersRepository,
                    selectedCharacter: selectedCharacter
                )
            }
        )
    }
}

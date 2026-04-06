//
//  DependenciesContainer.swift
//  RickAndMortyApp
//
//  Created by Pablo Romero on 29/3/26.
//

import Foundation
import Data
import Domain
import Networking
import Presentation

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

extension DependenciesContainer: CharactersListViewModelFactory {
    func makeCharactersListViewModel(
        selectedCharacter: @escaping (Character) -> Void
    ) -> CharactersListViewModel {
        CharactersListViewModel(
            repository: charactersRepository,
            selectedCharacter: selectedCharacter
        )
    }
}

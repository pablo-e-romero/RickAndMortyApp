//
//  DependenciesContainer.swift
//  RickAndMortyApp
//
//  Created by Pablo Romero on 29/3/26.
//

import Foundation

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

protocol HasCharactersRepository {
    var charactersRepository: CharactersRepository { get }
}

extension DependenciesContainer: HasCharactersRepository { }

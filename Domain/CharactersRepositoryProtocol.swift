//
//  CharactersRepositoryProtocol.swift
//  RickAndMortyApp
//
//  Created by Pablo Romero on 29/3/26.
//

protocol CharactersRepositoryProtocol {
    func fetchCharacters(
        name: String?,
        page: Int?
    ) async throws -> Paginated<Character>
}

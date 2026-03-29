//
//  CharactersRepository.swift
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

struct CharactersRepository {
    private let service: APIServiceProtocol
    
    init(service: APIServiceProtocol) {
        self.service = service
    }
}

extension CharactersRepository: CharactersRepositoryProtocol {
    func fetchCharacters(
        name: String?,
        page: Int?
    ) async throws -> Paginated<Character> {
        try await service.execute(
            .character(name: name, page: page)
        ).toDomain()
    }
}

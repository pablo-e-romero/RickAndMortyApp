//
//  CharactersRepository.swift
//  RickAndMortyApp
//
//  Created by Pablo Romero on 30/3/26.
//

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
        do {
            let response = try await service.execute(
                .character(name: name, page: page)
            )
            return response.toDomain()
        } catch APIServiceError.notFound {
            return .empty
        }
    }
}

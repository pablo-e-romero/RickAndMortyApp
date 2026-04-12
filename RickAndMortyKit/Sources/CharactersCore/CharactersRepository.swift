import Common
import Foundation
import Networking

public struct CharactersRepository: CharactersRepositoryProtocol {
    private let service: APIServiceProtocol

    public init(service: APIServiceProtocol) {
        self.service = service
    }

    public func fetchCharacters(
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

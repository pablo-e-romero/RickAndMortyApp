import Foundation
import Domain

public final class MockCharactersRepository: CharactersRepositoryProtocol, @unchecked Sendable {
    public var result: Result<Paginated<Character>, Error> = .success(.empty)
    public private(set) var fetchCallCount = 0
    public private(set) var lastRequestedName: String?
    public private(set) var lastRequestedPage: Int?

    public init() {}
    
    public func fetchCharacters(
        name: String?,
        page: Int?
    ) async throws -> Paginated<Character> {
        fetchCallCount += 1
        lastRequestedName = name
        lastRequestedPage = page
        return try result.get()
    }
}

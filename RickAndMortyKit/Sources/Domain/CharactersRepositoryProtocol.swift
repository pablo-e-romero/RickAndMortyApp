public protocol CharactersRepositoryProtocol: Sendable {
    func fetchCharacters(
        name: String?,
        page: Int?
    ) async throws -> Paginated<Character>
}

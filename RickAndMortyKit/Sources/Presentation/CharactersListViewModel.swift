import Foundation
import Common
import Domain

public protocol CharactersListViewModelFactory {
    func makeCharactersListViewModel(
        selectedCharacter: @escaping (Character) -> Void
    ) -> CharactersListViewModel
}

@Observable
public final class CharactersListViewModel {
    public struct DisplayModel {
        public let characters: [Character]
        public let hasMore: Bool

        public init(characters: [Character], hasMore: Bool) {
            self.characters = characters
            self.hasMore = hasMore
        }
    }

    public internal(set) var state: State<DisplayModel> = .idle
    public var searchText: String = ""

    private let repository: CharactersRepositoryProtocol
    private let selectedCharacter: (Character) -> Void
    private var nextPage: Int?

    public init(
        repository: CharactersRepositoryProtocol,
        selectedCharacter: @escaping (Character) -> Void
    ) {
        self.repository = repository
        self.selectedCharacter = selectedCharacter
    }

    public func fetchFirstPage() async {
        await fetch(name: searchText, page: Page.firstPage)
    }

    public func fetchNextPage() async {
        guard let nextPage else { return }
        await fetch(name: searchText, page: nextPage)
    }

    public func onSearch(_ text: String) async {
        try? await Task.sleep(for: .milliseconds(300))
        guard !Task.isCancelled else { return }
        await fetch(name: text, page: Page.firstPage)
    }

    public func onCharacterSelected(_ character: Character) {
        selectedCharacter(character)
    }
}

private extension CharactersListViewModel {
    func fetch(name: String? = nil, page: Int) async {
        state.toLoading()

        do {
            let characters = try await repository.fetchCharacters(
                name: name ?? searchText,
                page: page
            )

            nextPage = characters.page.nextPage

            let list = page == Page.firstPage ?
            characters.results :
            (state.content?.characters ?? []) + characters.results

            state = .loaded(
                DisplayModel(
                    characters: list,
                    hasMore: characters.page.hasMore
                )
            )
        } catch {
            state.toError(error)
        }
    }
}

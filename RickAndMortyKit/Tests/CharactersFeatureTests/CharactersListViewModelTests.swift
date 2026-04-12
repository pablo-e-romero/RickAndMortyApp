import Testing
import Common
import Foundation
import Clocks
import CharactersCore
import CharactersCoreMocks
@testable import CharactersFeature

@MainActor
@Suite("CharactersListViewModel")
struct CharactersListViewModelTests {
    var repository: MockCharactersRepository!
    var clock: ImmediateClock<Duration>!
    
    // MARK: - Initial state
    
    init() {
        self.repository = MockCharactersRepository()
        self.repository.result = .success(.empty)
        self.clock = ImmediateClock()
    }

    @Test("Initial state is idle")
    func initialStateIsIdle() {
        let sut = makeSUT()
        guard case .idle = sut.state else {
            Issue.record("Expected idle state, got \(sut.state)")
            return
        }
    }

    // MARK: - fetchFirstPage

    @Test("fetchFirstPage loads characters and sets loaded state")
    func fetchFirstPageSuccess() async {
        let characters: [Character] = [.rick()]
        let paginated = Paginated(
            page: Page(hasMore: false, nextPage: nil),
            results: characters
        )
        repository.result = .success(paginated)
        let sut = makeSUT()

        await sut.fetchFirstPage()

        #expect(repository.fetchCallCount == 1)
        #expect(repository.lastRequestedPage == Page.firstPage)

        guard case let .loaded(displayModel) = sut.state else {
            Issue.record("Expected loaded state")
            return
        }
        #expect(displayModel.characters.count == 1)
        #expect(displayModel.characters.first?.id == characters.first?.id)
        #expect(displayModel.hasMore == false)
    }

    @Test("fetchFirstPage sets error state on failure")
    func fetchFirstPageError() async {
        let expectedError = URLError(.notConnectedToInternet)
        repository.result = .failure(expectedError)
        let sut = makeSUT()

        await sut.fetchFirstPage()

        guard case .error = sut.state else {
            Issue.record("Expected error state, got \(sut.state)")
            return
        }
    }

    // MARK: - fetchNextPage

    @Test("fetchNextPage does nothing when there is no next page")
    func fetchNextPageNoNextPage() async {
        let paginated = Paginated<Character>(
            page: Page(hasMore: false, nextPage: nil),
            results: [.rick()]
        )
        repository.result = .success(paginated)
        let sut = makeSUT()

        // Load first page (no next page)
        await sut.fetchFirstPage()
        let callCountAfterFirstPage = repository.fetchCallCount

        // Try to fetch next page
        await sut.fetchNextPage()

        #expect(repository.fetchCallCount == callCountAfterFirstPage)
    }

    @Test("fetchNextPage appends results to existing characters")
    func fetchNextPageAppendsResults() async {
        let rick = Character.rick()
        let morty = Character.morty()

        let firstPage = Paginated(
            page: Page(hasMore: true, nextPage: 2),
            results: [rick]
        )
        repository.result = .success(firstPage)
        let sut = makeSUT()

        await sut.fetchFirstPage()

        // Update mock for second page
        let secondPage = Paginated(
            page: Page(hasMore: false, nextPage: nil),
            results: [morty]
        )
        repository.result = .success(secondPage)

        await sut.fetchNextPage()

        #expect(repository.lastRequestedPage == 2)

        guard case let .loaded(displayModel) = sut.state else {
            Issue.record("Expected loaded state")
            return
        }
        #expect(displayModel.characters.count == 2)
        #expect(displayModel.characters[0].id == rick.id)
        #expect(displayModel.characters[1].id == morty.id)
        #expect(displayModel.hasMore == false)
    }

    // MARK: - fetchFirstPage resets

    @Test("fetchFirstPage resets list instead of appending")
    func fetchFirstPageResetsResults() async {
        let rick = Character.rick()
        let morty = Character.morty()

        let firstPage = Paginated(
            page: Page(hasMore: true, nextPage: 2),
            results: [rick]
        )
        repository.result = .success(firstPage)
        let sut = makeSUT()
        
        await sut.fetchFirstPage()

        // Fetch next page
        let secondPage = Paginated(
            page: Page(hasMore: false, nextPage: nil),
            results: [morty]
        )
        repository.result = .success(secondPage)
        await sut.fetchNextPage()

        // Now fetch first page again with new data
        let refreshPage = Paginated(
            page: Page(hasMore: false, nextPage: nil),
            results: [rick]
        )
        repository.result = .success(refreshPage)
        await sut.fetchFirstPage()

        guard case let .loaded(displayModel) = sut.state else {
            Issue.record("Expected loaded state")
            return
        }
        #expect(displayModel.characters.count == 1)
        #expect(displayModel.characters[0].id == rick.id)
    }

    // MARK: - onCharacterSelected

    @Test("onCharacterSelected invokes callback with character")
    func onCharacterSelectedCallsCallback() {
        var selectedCharacter: Character?
        let sut = makeSUT(selectedCharacter: { selectedCharacter = $0 })

        let character = Character.rick()
        sut.onCharacterSelected(character)

        #expect(selectedCharacter?.id == character.id)
    }
    
    // MARK: - onSearch
    
    @Test("onSearch loads characters and sets loaded state")
    func onSearch() async {
        let characters: [Character] = [.rick(), .morty()]
        let paginated = Paginated(
            page: Page(hasMore: false, nextPage: nil),
            results: characters
        )
        repository.result = .success(paginated)
        let sut = makeSUT()

        await sut.onSearch("Rick")

        #expect(repository.fetchCallCount == 1)
        #expect(repository.lastRequestedName == "Rick")
        #expect(repository.lastRequestedPage == Page.firstPage)

        guard case let .loaded(displayModel) = sut.state else {
            Issue.record("Expected loaded state")
            return
        }
        #expect(displayModel.characters.count == 2)
        #expect(displayModel.hasMore == false)
    }
    
    // MARK: - SUT
    
    private func makeSUT(
        selectedCharacter: @escaping (Character) -> Void = { _ in }
    ) -> CharactersListViewModel {
        CharactersListViewModel(
            repository: repository,
            selectedCharacter: selectedCharacter,
//            clock: clock
        )
    }
}

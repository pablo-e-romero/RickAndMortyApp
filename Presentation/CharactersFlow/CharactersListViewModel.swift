//
//  CharactersListViewModel.swift
//  RickAndMortyApp
//
//  Created by Pablo Romero on 29/3/26.
//

import Foundation

protocol CharactersListViewModelFactory {
    func makeCharactersListViewModel(
        selectedCharacter: @escaping (Character) -> Void
    ) -> CharactersListViewModel
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

@Observable
final class CharactersListViewModel {
    struct DisplayModel {
        let characters: [Character]
        let hasMore: Bool
    }

    private(set) var state: State<DisplayModel> = .idle
    var searchText: String = ""
    
    private let repository: CharactersRepositoryProtocol
    private let selectedCharacter: (Character) -> Void
    private var nextPage: Int?

    init(
        repository: CharactersRepositoryProtocol,
        selectedCharacter: @escaping (Character) -> Void
    ) {
        self.repository = repository
        self.selectedCharacter = selectedCharacter
    }
    
    func fetchFirstPage() async {
        await fetch(name: searchText, page: Page.firstPage)
    }
    
    func fetchNextPage() async {
        guard let nextPage else { return }
        await fetch(name: searchText, page: nextPage)
    }
    
    func onSearch(_ text: String) async {
        try? await Task.sleep(for: .milliseconds(300))
        guard !Task.isCancelled else { return }
        await fetch(name: text, page: Page.firstPage)
    }
    
    func onCharacterSelected(_ character: Character) {
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

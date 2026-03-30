//
//  CharactersListViewModel.swift
//  RickAndMortyApp
//
//  Created by Pablo Romero on 29/3/26.
//

import Foundation

protocol CharactersListViewModelFactory {
    func makeCharactersListViewModel() -> CharactersListViewModel
}

extension DependenciesContainer: CharactersListViewModelFactory {
    func makeCharactersListViewModel() -> CharactersListViewModel {
        CharactersListViewModel(repository: charactersRepository)
    }
}

@Observable
final class CharactersListViewModel {
    struct DisplayModel {
        let characters: [Character]
        let hasMore: Bool
    }
    
    private let repository: CharactersRepositoryProtocol
    
    private(set) var state: State<DisplayModel> = .idle
    private var nextPage: Int?

    init(repository: CharactersRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetch(name: String? = nil, page: Int = Page.firstPage) async {
        state.toLoading()
        
        do {
            let characters = try await repository.fetchCharacters(
                name: name,
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
    
    func fetchNextPage() async {
        guard let nextPage else { return }
        await fetch(page: nextPage)
    }
}

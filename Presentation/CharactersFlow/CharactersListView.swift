//
//  CharactersListView.swift
//  RickAndMortyApp
//
//  Created by Pablo Romero on 29/3/26.
//

import SwiftUI

struct CharactersListView: View {
    @Bindable var viewModel: CharactersListViewModel
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .idle, .loading:
                Text("Loading")
            case let .loaded(displayModel):
                LoadedView(
                    searchText: $viewModel.searchText,
                    displayModel: displayModel,
                    fetchNextPage: viewModel.fetchNextPage,
                    refresh: viewModel.fetchFirstPage
                )
            case let .error(error):
                Text(error.localizedDescription)
            }
        }
        .navigationTitle("Characters")
        .task {
            await viewModel.fetchFirstPage()
        }
        .task(id: viewModel.searchText) {
            await viewModel.onSearch(viewModel.searchText)
        }
    }
}

struct LoadedView: View {
    @Binding var searchText: String
    let displayModel: CharactersListViewModel.DisplayModel
    let fetchNextPage: () async -> Void
    let refresh: () async -> Void

    var body: some View {
        List {
            ForEach(displayModel.characters) { character in
                NavigationLink(value: Route.detail(character)) {
                    Text(character.name)
                        .task {
                            if character == displayModel.characters.last,
                               displayModel.hasMore {
                                await fetchNextPage()
                            }
                        }
                }
            }
            if displayModel.hasMore {
                ProgressView()
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .searchable(text: $searchText)
        .refreshable {
            await refresh()
        }
    }
}

//#Preview {
//    CharactersListView()
//}

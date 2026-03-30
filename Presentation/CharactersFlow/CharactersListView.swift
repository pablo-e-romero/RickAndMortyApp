//
//  CharactersListView.swift
//  RickAndMortyApp
//
//  Created by Pablo Romero on 29/3/26.
//

import SwiftUI

struct CharactersListView: View {
    let viewModel: CharactersListViewModel
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .idle, .loading:
                Text("Loading")
            case let .loaded(displayModel):
                LoadedView(
                    displayModel: displayModel,
                    fetchNextPage: viewModel.fetchNextPage
                )
            case let .error(error):
                Text(error.localizedDescription)
            }
        }
        .navigationTitle("Characters")
        .task {
            await viewModel.onTask()
        }
    }
}

struct LoadedView: View {
    let displayModel: CharactersListViewModel.DisplayModel
    let fetchNextPage: () async -> Void

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
    }
}

//#Preview {
//    CharactersListView()
//}

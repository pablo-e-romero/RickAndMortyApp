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
                LoadedView(displayModel: displayModel)
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
    
    var body: some View {
        List(displayModel.characters) { character in
            NavigationLink(value: Route.detail(character)) {
                Text(character.name)
            }
        }
    }
}

//#Preview {
//    CharactersListView()
//}

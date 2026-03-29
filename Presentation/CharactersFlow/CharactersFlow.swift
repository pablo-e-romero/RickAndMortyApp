//
//  CharactersFlow.swift
//  RickAndMortyApp
//
//  Created by Pablo Romero on 29/3/26.
//

import SwiftUI

enum Route: Hashable {
    case detail(Character)
}

struct CharactersFlow: View {
    typealias Dependencies = CharactersListViewModelFactory
    let depdendecies: Dependencies

    @SwiftUI.State var route: [Route] = []

    var body: some View {
        NavigationStack(path: $route) {
            CharactersListView(
                viewModel: depdendecies.makeCharactersListViewModel()
            )
            .navigationDestination(for: Route.self) { route in
                switch route {
                case let .detail(character):
                    CharacterDetailView(character: character)
                }
            }
        }
    }
}

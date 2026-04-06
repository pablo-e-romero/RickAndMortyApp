//
//  CharactersListView.swift
//  RickAndMortyApp
//
//  Created by Pablo Romero on 29/3/26.
//

import SwiftUI
import Kingfisher

struct CharactersListView: View {
    @Bindable var viewModel: CharactersListViewModel

    var body: some View {
        Group {
            switch viewModel.state {
            case .idle, .loading:
                LoadingView()
            case let .loaded(displayModel):
                LoadedView(
                    searchText: $viewModel.searchText,
                    displayModel: displayModel,
                    characterSelected: viewModel.onCharacterSelected,
                    fetchNextPage: viewModel.fetchNextPage,
                    refresh: viewModel.fetchFirstPage
                )
            case .error:
                ErrorView(retry: viewModel.fetchFirstPage)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Characters")
        .task(id: viewModel.searchText) {
            await viewModel.onSearch(viewModel.searchText)
        }
    }
}

// MARK - Loading

private struct LoadingView: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(0..<4) { _ in
                    LoadingRowView()
                }
            }
        }
    }
}

private struct LoadingRowView: View {
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 8)
                .fill(.tertiary)
                .aspectRatio(contentMode: .fill)
       
            Text("redacted.name")
                .font(.title3)
                .foregroundStyle(.primary)
                .padding(6)
                .background(
                    Material.thin,
                    in: RoundedRectangle(
                        cornerRadius: 8,
                        style: .continuous
                    )
                )
                .padding(6)
        }
        .padding(EdgeInsets(top: 3, leading: 6, bottom: 3, trailing: 6))
        .redacted(reason: .placeholder)
    }
}

// MARK - Loaded

private struct LoadedView: View {
    @Binding var searchText: String
    let displayModel: CharactersListViewModel.DisplayModel
    let characterSelected: (Character) -> Void
    let fetchNextPage: () async -> Void
    let refresh: () async -> Void

    var body: some View {
        Group {
            if displayModel.characters.isEmpty {
                Text("No characters found")
            } else {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(displayModel.characters) { character in
                            RowView(character: character)
                                .onTapGesture {
                                    characterSelected(character)
                                }
                                .task {
                                    if character == displayModel.characters.last,
                                       displayModel.hasMore {
                                        await fetchNextPage()
                                    }
                                }
                        }
                        if displayModel.hasMore {
                            ProgressView()
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                }
                .refreshable { await refresh() }
            }
        }
        .searchable(text: $searchText)
    }
}

private struct RowView: View {
    let character: Character

    var body: some View {
        ZStack(alignment: .topLeading) {
            KFImage.url(character.image)
                .placeholder {
                    ProgressView()
                }
                .resizable()
                .scaledToFill()
                .cornerRadius(8)
       
            Text(character.name)
                .font(.title3)
                .foregroundStyle(.primary)
                .padding(6)
                .background(
                    Material.thin,
                    in: RoundedRectangle(
                        cornerRadius: 8,
                        style: .continuous
                    )
                )
                .padding(6)
        }
        .padding(EdgeInsets(top: 3, leading: 6, bottom: 3, trailing: 6))
    }
}

// MARK - Error

private struct ErrorView: View {
    let retry: () async -> Void
    var body: some View {
        VStack(spacing: 16) {
            Text("There was an error loading characters")
            Button("Retry") {
                Task { await retry() }
            }
        }
    }
}

// MARK - Previews
        
#Preview("Without more pages") {
    NavigationStack {
        LoadedView(
            searchText: .constant(""),
            displayModel: .init(
                characters: [
                    .sample()
                ],
                hasMore: false
            ),
            characterSelected: { _ in },
            fetchNextPage: {},
            refresh: {}
        )
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Characters")
    }
}

#Preview("With more pages") {
    NavigationStack {
        LoadedView(
            searchText: .constant(""),
            displayModel: .init(
                characters: [
                    .sample()
                ],
                hasMore: true
            ),
            characterSelected: { _ in },
            fetchNextPage: {},
            refresh: {}
        )
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Characters")
    }
}

#Preview("Empty") {
    NavigationStack {
        LoadedView(
            searchText: .constant(""),
            displayModel: .init(
                characters: [],
                hasMore: false
            ),
            characterSelected: { _ in },
            fetchNextPage: {},
            refresh: {}
        )
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Characters")
    }
}

#Preview("Loading") {
    NavigationStack {
        LoadingView()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Characters")
    }
}

#Preview("Error") {
    NavigationStack {
        ErrorView(retry: {})
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Characters")
    }
}

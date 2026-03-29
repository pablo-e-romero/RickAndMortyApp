//
//  ContentView.swift
//  RickAndMortyApp
//
//  Created by Pablo Romero on 26/3/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .task {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let service = APIService(
                baseURL: RicketAndMortyAPIConstants.baseURL,
                decoder: decoder
            )
            
            let repository = CharactersRepository(service: service)
            
            let characters = try? await repository.fetchCharacters(name: "rick", page: 6)
            print(characters?.results.count)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

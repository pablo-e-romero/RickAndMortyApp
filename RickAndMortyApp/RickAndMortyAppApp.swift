//
//  RickAndMortyAppApp.swift
//  RickAndMortyApp
//
//  Created by Pablo Romero on 26/3/26.
//

import SwiftUI
import Presentation

@main
struct RickAndMortyAppApp: App {
    static let dependencies: DependenciesContainer = .live

    var body: some Scene {
        WindowGroup {
            CharactersFlow(dependencies: Self.dependencies)
        }
    }
}

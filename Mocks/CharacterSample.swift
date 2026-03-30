//
//  CharacterSample.swift
//  RickAndMortyApp
//
//  Created by Pablo Romero on 30/3/26.
//

import Foundation

extension Character {
    static func sample() -> Self {
        Character(
            id: 1,
            name: "Rick Sanchez",
            type: "",
            episode: [
                URL(string: "https://rickandmortyapi.com/api/episode/1")!,
                URL(string: "https://rickandmortyapi.com/api/episode/2")!,
                URL(string: "https://rickandmortyapi.com/api/episode/3")!,
                URL(string: "https://rickandmortyapi.com/api/episode/4")!
            ],
            image: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!,
            content: URL(string: "https://rickandmortyapi.com/api/character/1")!,
            created: Date()
        )
    }
}

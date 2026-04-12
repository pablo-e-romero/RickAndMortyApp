import Foundation
import CharactersCore

public extension Character {
    static func rick() -> Self {
        Character(
            id: 1,
            name: "Rick Sanchez",
            status: "Alive",
            species: "Human",
            gender: "Male",
            origin: "Earth",
            location: "Citadel of Ricks",
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
    
    static func morty() -> Self {
        Character(
           id: 2,
           name: "Morty Smith",
           status: "Alive",
           species: "Human",
           gender: "Male",
           origin: "Earth",
           location: "Earth",
           episode: [],
           image: nil,
           content: nil,
           created: Date()
       )
    }
}

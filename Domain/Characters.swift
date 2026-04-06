//
//  Characters.swift
//  RickAndMortyApp
//
//  Created by Pablo Romero on 29/3/26.
//

import Foundation

struct Character: Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let origin: String?
    let location: String?
    let episode: [URL]
    let image: URL?
    let content: URL?
    let created: Date
}

extension Character: Hashable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

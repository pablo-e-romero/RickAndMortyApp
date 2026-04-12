//
//  Route.swift
//  RickAndMortyKit
//
//  Created by Pablo Romero on 12/04/2026.
//

import Foundation
import CharactersCore

enum Route: Hashable {
    struct Detail: Hashable {
        let character: CharactersCore.Character
        let pictureSelected: (CharactersCore.Character) -> Void
    }
    
    case detail(Detail)
    case picture(CharactersCore.Character)
}

extension Route.Detail {
    func hash(into hasher: inout Hasher) {
        character.hash(into: &hasher)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.character == rhs.character
    }
}

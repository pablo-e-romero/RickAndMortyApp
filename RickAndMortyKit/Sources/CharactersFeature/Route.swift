//
//  Route.swift
//  RickAndMortyKit
//
//  Created by Pablo Romero on 12/04/2026.
//

import Domain
import Foundation

enum Route: Hashable {
    struct Detail: Hashable {
        let character: Domain.Character
        let pictureSelected: (Domain.Character) -> Void
    }
    
    case detail(Detail)
    case picture(Domain.Character)
}

extension Route.Detail {
    func hash(into hasher: inout Hasher) {
        character.hash(into: &hasher)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.character == rhs.character
    }
}

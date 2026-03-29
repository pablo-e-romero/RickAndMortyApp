//
//  CharacterDetailView.swift
//  RickAndMortyApp
//
//  Created by Pablo Romero on 29/3/26.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: Character

    var body: some View {
        Text(character.name)
    }
}

//#Preview {
//    CharacterDetailView()
//}

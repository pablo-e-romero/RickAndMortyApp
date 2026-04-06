//
//  CharacterDetailView.swift
//  RickAndMortyApp
//
//  Created by Pablo Romero on 29/3/26.
//

import SwiftUI
import Kingfisher
import WebKit

struct CharacterDetailView: View {
    let character: Character

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                KFImage.url(character.image)
                    .placeholder {
                        ProgressView()
                    }
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(8)
                    .padding(6)
                
                Grid(alignment: .leading) {
                    GridRow {
                        gridRowName("Status")
                        gridRowContent(character.status)
                    }
                    GridRow {
                        gridRowName("Species")
                        gridRowContent(character.species)
                    }
                    
                    GridRow {
                        gridRowName("Gender")
                        gridRowContent(character.gender)
                    }
                    
                    if let origin = character.origin {
                        GridRow {
                            gridRowName("Origin")
                            gridRowContent(origin)
                        }
                    }
                    
                    if let location = character.location {
                        GridRow {
                            gridRowName("Location")
                            gridRowContent(location)
                        }
                    }
                }
                .padding(6)
            }
        }
        .navigationTitle(character.name)
    }
    
    private func gridRowName(_ text: String) -> some View {
        Text(text)
            .font(.default)
            .bold()
    }
    
    private func gridRowContent(_ text: String) -> some View {
        Text(text)
            .font(.default)
    }
}

#Preview {
    NavigationStack {
        CharacterDetailView(character: .sample())
    }
}

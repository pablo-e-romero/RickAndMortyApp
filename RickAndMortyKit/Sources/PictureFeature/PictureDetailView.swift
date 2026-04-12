//
//  PictureDetailView.swift
//  RickAndMortyKit
//
//  Created by Pablo Romero on 12/04/2026.
//

import SwiftUI
import Kingfisher

public struct PictureDetailView: View {
    let url: URL?
    let accessibilityLabel: String
    
    public init(url: URL?, accessibilityLabel: String) {
        self.url = url
        self.accessibilityLabel = accessibilityLabel
    }
    
    public var body: some View {
        KFImage.url(url)
            .placeholder {
                ProgressView()
            }
            .resizable()
            .scaledToFill()
            .cornerRadius(8)
            .padding(6)
            .accessibilityLabel(accessibilityLabel)
    }
}

#Preview {
    PictureDetailView(
        url: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"),
        accessibilityLabel: "Portrait of Rick"
    )
}

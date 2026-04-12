//
//  PictureDetailView.swift
//  RickAndMortyKit
//
//  Created by Pablo Romero on 12/04/2026.
//

import SwiftUI
import Domain
import Kingfisher
import Mocks

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
    @Previewable let morty = Domain.Character.morty()

    PictureDetailView(
        url: morty.image,
        accessibilityLabel: "Portrait of \(morty.name)"
    )
}

import SwiftUI
import Kingfisher
import CharactersCore
import CharactersCoreMocks

struct CharacterDetailView: View {
    let character: Character
    let pictureSelected: (Character) -> Void
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Button {
                    pictureSelected(character)
                } label: {
                    KFImage.url(character.image)
                        .placeholder {
                            ProgressView()
                        }
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(8)
                        .padding(6)
                        .accessibilityLabel("Portrait of \(character.name)")
                }
                .buttonStyle(.plain)

                Grid(alignment: .leading) {
                    GridRow {
                        gridRowName("Status")
                        gridRowContent(character.status)
                    }
                    .accessibilityElement(children: .combine)
                    GridRow {
                        gridRowName("Species")
                        gridRowContent(character.species)
                    }
                    .accessibilityElement(children: .combine)

                    GridRow {
                        gridRowName("Gender")
                        gridRowContent(character.gender)
                    }
                    .accessibilityElement(children: .combine)

                    if let origin = character.origin {
                        GridRow {
                            gridRowName("Origin")
                            gridRowContent(origin)
                        }
                        .accessibilityElement(children: .combine)
                    }

                    if let location = character.location {
                        GridRow {
                            gridRowName("Location")
                            gridRowContent(location)
                        }
                        .accessibilityElement(children: .combine)
                    }
                }
                .padding(6)
            }
        }
        .navigationTitle(character.name)
    }

    private func gridRowName(_ text: String) -> some View {
        Text(text)
            .font(.body)
            .bold()
    }

    private func gridRowContent(_ text: String) -> some View {
        Text(text)
            .font(.body)
    }
}

#Preview {
    NavigationStack {
        CharacterDetailView(
            character: .rick(),
            pictureSelected: { _ in }
        )
    }
}

import SwiftUI
import Kingfisher
import Domain
import Mocks

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
        CharacterDetailView(character: .rick())
    }
}

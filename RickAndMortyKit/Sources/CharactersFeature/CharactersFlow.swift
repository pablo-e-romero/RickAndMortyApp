import SwiftUI
import Domain

public struct CharactersFlow<PictureDetailView: View>: View {
    let dependencies: DependenciesContainer<PictureDetailView>

    @SwiftUI.State var route: [Route] = []

    public init(dependencies: DependenciesContainer<PictureDetailView>) {
        self.dependencies = dependencies
    }

    public var body: some View {
        NavigationStack(path: $route) {
            CharactersListView(
                viewModel: dependencies.makeCharactersListViewModel(
                    selectedCharacter: { character in
                        route.append(
                            .detail(Route.Detail(
                                character: character,
                                pictureSelected: { character in
                                    route.append(.picture(character))
                                })
                            )
                        )
                    }
                )
            )
            .navigationDestination(for: Route.self) { route in
                switch route {
                case let .detail(info):
                    CharacterDetailView(
                        character: info.character,
                        pictureSelected: info.pictureSelected
                    )
                case let .picture(character):
                    dependencies.makePictureDetailView(
                        url: character.image,
                        accessibilityLabel: "Portrait of \(character.name)"
                    )
                }
            }
        }
    }
}

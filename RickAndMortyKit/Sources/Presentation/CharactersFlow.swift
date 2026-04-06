import SwiftUI
import Domain

public enum Route: Hashable {
    case detail(Character)
}

public protocol CharactersListViewModelFactory {
    func makeCharactersListViewModel(
        selectedCharacter: @escaping (Character) -> Void
    ) -> CharactersListViewModel
}

public struct CharactersFlow<Dependencies: CharactersListViewModelFactory>: View {
    let dependencies: Dependencies

    @SwiftUI.State var route: [Route] = []

    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    public var body: some View {
        NavigationStack(path: $route) {
            CharactersListView(
                viewModel: dependencies.makeCharactersListViewModel(
                    selectedCharacter: { character in
                        route.append(.detail(character))
                    }
                )
            )
            .navigationDestination(for: Route.self) { route in
                switch route {
                case let .detail(character):
                    CharacterDetailView(character: character)
                }
            }
        }
    }
}

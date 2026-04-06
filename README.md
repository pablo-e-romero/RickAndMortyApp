# RickAndMortyApp

![image](Images/Demo.gif)

A SwiftUI app that browses characters from the [Rick and Morty API](https://rickandmortyapi.com). 

Users can scroll through a paginated list, search by name, and view detailed character information.


## Architecture

The project follows **MVVM** with a modular **Swift Package Manager** structure. 

All core logic lives in the `RickAndMortyKit` local package, while the main app target handles only dependency injection and the entry point.

### Modules

![image](Images/Modules.png)

| Module | Purpose | Dependencies |
|---|---|---|
| **Common** | Shared utilities — generic `State<Content>` enum for async state management, `URL` extensions | None |
| **Domain** | Business models (`Character`, `Page`, `Paginated`) and the `CharactersRepositoryProtocol` | None |
| **Networking** | HTTP abstraction — `APIService`, `APIEndpoint`, `APIServiceError` | None |
| **Data** | Repository implementation, DTO-to-domain mapping, API endpoint configuration | Common, Domain, Networking |
| **Mocks** | Sample data (`Character.rick()`, `.morty()`) and `MockCharactersRepository` for previews and tests | Domain |
| **Presentation** | SwiftUI views, `CharactersListViewModel` (`@Observable`), navigation flow via `CharactersFlow` | Common, Domain, Mocks, Kingfisher |

### Key patterns

- **MVVM** — `CharactersListViewModel` holds state and business logic; views are purely declarative.
- **Protocol-based DI** — `CharactersRepositoryProtocol` and `CharactersListViewModelFactory` enable swapping implementations for testing.
- **Composition Root** — `DependenciesContainer` in the app target wires all concrete types and conforms to factory protocols.
- **Async/Await** — All asynchronous operations use structured concurrency with `@MainActor` isolation.
- **`@Observable`** — iOS 17+ observation for reactive UI updates without Combine.
- **State machine** — `State<Content>` enum enforces valid transitions (idle → loading → loaded/error).
- **DTO mapping** — `CharacaterDto.toDomain()` keeps API response shapes out of the domain layer.
- **Debounced search** — 300ms delay with `Task.isCancelled` check to reduce API calls.
- **Infinite scroll** — Pagination via `Page.nextPage`, triggered when the last item appears.

## Tech stack

| | |
|---|---|
| UI | SwiftUI |
| Concurrency | async/await, @MainActor, @Observable |
| Networking | URLSession |
| Image loading | [Kingfisher](https://github.com/onevcat/Kingfisher) 8.x |
| Testing | Swift Testing framework |
| Min deployment | iOS 17 |

## Tests

Unit tests for `CharactersListViewModel` live in `RickAndMortyKit/Tests/PresentationTests` and use the Swift Testing framework. Run them with:

```bash
cd RickAndMortyKit
swift test --filter PresentationTests
```

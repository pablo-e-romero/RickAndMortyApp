import Foundation
import Common
import Domain
import Networking

struct CharacaterDto: Decodable {
    struct PageDto: Decodable {
        let count: Int
        let pages: Int
        let next: URL?

        func toDomain() -> Page {
            let nextPage: Int? = next?.getQueryItemValue("page").flatMap { Int($0) }

            return Page(
                hasMore: nextPage != nil,
                nextPage: nextPage
            )
        }
    }

    struct CharacterDto: Decodable {
        let id: Int
        let name: String
        let status: String
        let species: String
        let gender: String
        let origin: OriginDto?
        let location: LocationDto?
        let image: URL?
        let episode: [URL]
        let url: URL?
        let created: Date

        func toDomain() -> Character {
            .init(
                id: id,
                name: name,
                status: status,
                species: species,
                gender: gender,
                origin: origin?.name,
                location: location?.name,
                episode: episode,
                image: image,
                content: url,
                created: created
            )
        }
    }

    struct OriginDto: Decodable {
        let name: String
    }

    struct LocationDto: Decodable {
        let name: String
    }

    let info: PageDto
    let results: [CharacterDto]

    func toDomain() -> Paginated<Character> {
        .init(
            page: info.toDomain(),
            results: results.map { $0.toDomain() }
        )
    }
}

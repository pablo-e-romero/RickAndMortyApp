import Foundation

public struct Character: Identifiable, Sendable {
    public let id: Int
    public let name: String
    public let status: String
    public let species: String
    public let gender: String
    public let origin: String?
    public let location: String?
    public let episode: [URL]
    public let image: URL?
    public let content: URL?
    public let created: Date

    public init(
        id: Int,
        name: String,
        status: String,
        species: String,
        gender: String,
        origin: String?,
        location: String?,
        episode: [URL],
        image: URL?,
        content: URL?,
        created: Date
    ) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.gender = gender
        self.origin = origin
        self.location = location
        self.episode = episode
        self.image = image
        self.content = content
        self.created = created
    }
}

extension Character: Hashable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

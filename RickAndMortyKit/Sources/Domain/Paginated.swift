public struct Page: Sendable {
    public static let firstPage = 1
    public let hasMore: Bool
    public let nextPage: Int?

    public init(hasMore: Bool, nextPage: Int?) {
        self.hasMore = hasMore
        self.nextPage = nextPage
    }
}

public struct Paginated<Content>: Sendable where Content: Sendable {
    public let page: Page
    public let results: [Content]

    public init(page: Page, results: [Content]) {
        self.page = page
        self.results = results
    }
}

public extension Paginated {
    static var empty: Self {
        .init(
            page: .init(hasMore: false, nextPage: 0),
            results: []
        )
    }
}

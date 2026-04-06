//
//  Paginated.swift
//  RickAndMortyApp
//
//  Created by Pablo Romero on 29/3/26.
//

struct Page {
    static let firstPage = 1
    let hasMore: Bool
    let nextPage: Int?
}

struct Paginated<Content> {
    let page: Page
    let results: [Content]
}

extension Paginated {
    static var empty: Self {
        .init(
            page: .init(hasMore: false, nextPage: 0),
            results: []
        )
    }
}

//
//  Paginated.swift
//  RickAndMortyApp
//
//  Created by Pablo Romero on 29/3/26.
//

struct Page {
    let hasMore: Bool
    let nextPage: Int?
}

struct Paginated<Content> {
    let page: Page
    let results: [Content]
}

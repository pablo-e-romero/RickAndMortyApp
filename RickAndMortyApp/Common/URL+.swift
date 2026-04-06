//
//  URL+.swift
//  RickAndMortyApp
//
//  Created by Pablo Romero on 29/3/26.
//

import Foundation

extension URL {
    func getQueryItemValue(_ name: String) -> String? {
        guard
            let components = URLComponents(url: self, resolvingAgainstBaseURL: false),
            let queryItems = components.queryItems,
            let queryItem = queryItems.first(where: { $0.name == "page" })
        else { return nil }
        return queryItem.value
    }
}

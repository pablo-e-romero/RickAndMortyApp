//
//  RicketAndMortyAPI.swift
//  RickAndMortyApp
//
//  Created by Pablo Romero on 29/3/26.
//

import Foundation

enum RicketAndMortyAPIConstants {
    static let baseURL = URL(string: "https://rickandmortyapi.com/api/")!
}

extension APIEndpoint where Response == CharacaterDto {
    static func character(name: String?, page: Int?) -> Self {
        var queryParams = [String: String]()
        
        if let name, !name.isEmpty {
            queryParams["name"] = name
        }

        if let page {
            queryParams["page"] = "\(page)"
        }
        
        return .init(
            path: "character",
            queryParams: queryParams
        )
    }
}

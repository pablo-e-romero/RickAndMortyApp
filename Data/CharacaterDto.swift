//
//  CharacaterDto.swift
//  RickAndMortyApp
//
//  Created by Pablo Romero on 29/3/26.
//

import Foundation

struct CharacaterDto: Decodable {
    struct PageDto: Decodable {
        let count: Int
        let pages: Int
        let next: URL?
    }
    
    struct CharacterDto: Decodable {
        let id: Int
        let name: String
        let type: String
        let origin: LocationDto
        let location: LocationDto
        let image: URL?
        let episode: [String]
        let url: URL?
        let created: Date
    }
    
    struct LocationDto: Decodable {
        let name: String
        let url: String
    }

    let info: PageDto
    let results: [CharacterDto]
}

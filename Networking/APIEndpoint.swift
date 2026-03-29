//
//  APIEndpoint.swift
//  RickAndMortyApp
//
//  Created by Pablo Romero on 29/3/26.
//

import Foundation

struct APIEndpoint<Response: Decodable> {
    let path: String
    let queryParams: [String: CustomStringConvertible]
}

extension APIEndpoint {
    func urlRequest(baseURL: URL) -> URLRequest {
        guard var urlComponents = URLComponents(
            url: baseURL,
            resolvingAgainstBaseURL: true
        ) else {
            fatalError("Error initalizing URLBuilder")
        }
        
        urlComponents.path.append(path)
        urlComponents.queryItems = queryParams.map { (key, value) in
            URLQueryItem(name: key, value: value.description)
        }
        
        guard let url = urlComponents.url else {
            fatalError("Error buidling URL")
        }
        
        return URLRequest(url: url)
    }
}

//
//  APIService.swift
//  RickAndMortyApp
//
//  Created by Pablo Romero on 29/3/26.
//

import Foundation

protocol APIServiceProtocol: Sendable {
    func execute<Response: Decodable>(_ endPoint: APIEndpoint<Response>) async throws -> Response
}

struct APIService: APIServiceProtocol {
    let baseURL: URL
    let decoder: JSONDecoder
    
    init(baseURL: URL, decoder: JSONDecoder) {
        self.baseURL = baseURL
        self.decoder = decoder
    }
    
    func execute<Response: Decodable>(_ endPoint: APIEndpoint<Response>) async throws -> Response {
        let request = endPoint.urlRequest(baseURL: baseURL)
        let (data, _) = try await URLSession.shared.data(for: request)
        return try decoder.decode(Response.self, from: data)
    }
}

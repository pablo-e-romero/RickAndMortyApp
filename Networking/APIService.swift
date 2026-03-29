//
//  APIService.swift
//  RickAndMortyApp
//
//  Created by Pablo Romero on 29/3/26.
//

import Foundation

protocol APIService: Sendable {
    func execute<Response: Decodable>(_ endPoint: APIEndpoint<Response>) async throws -> Response
}

struct URLSessionAPIService: APIService {
    let baseURL: URL
    let decoder: JSONDecoder
    
    func execute<Response: Decodable>(_ endPoint: APIEndpoint<Response>) async throws -> Response {
        let request = endPoint.urlRequest(baseURL: baseURL)
        let (data, _) = try await URLSession.shared.data(for: request)
        return try decoder.decode(Response.self, from: data)
    }
}

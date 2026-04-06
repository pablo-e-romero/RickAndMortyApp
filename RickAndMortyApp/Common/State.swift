//
//  State.swift
//  RickAndMortyApp
//
//  Created by Pablo Romero on 29/3/26.
//

enum State<Content> {
    case idle
    case loading
    case loaded(Content)
    case error(Error)
}

extension State {
    mutating func toLoading() {
        switch self {
        case .idle, .error: self = .loading
        case .loading, .loaded: break
        }
    }
    
    mutating func toError(_ error: Error) {
        switch self {
        case .idle, .error, .loading: self = .error(error)
        case .loaded: break
        }
    }
    
    var content: Content? {
        guard case let .loaded(content) = self else {
            return nil
        }
        return content
    }
}

import Foundation

public struct APIEndpoint<Response: Decodable> {
    public let path: String
    public let queryParams: [String: CustomStringConvertible]

    public init(path: String, queryParams: [String: CustomStringConvertible]) {
        self.path = path
        self.queryParams = queryParams
    }
}

public extension APIEndpoint {
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

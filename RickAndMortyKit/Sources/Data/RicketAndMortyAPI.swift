import Foundation
import Networking

public enum RicketAndMortyAPIConstants {
    public static let baseURL = URL(string: "https://rickandmortyapi.com/api/")!
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

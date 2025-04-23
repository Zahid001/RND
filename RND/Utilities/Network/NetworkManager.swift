//
//  NetworkManager.swift
//  BTest
//
//  Created by Md Zahidul Islam Mazumder on 3/7/25.
//

import Foundation
import Combine

class NetworkManager {
    
    static func makeAPIRequest<T: Decodable>(
        endpoint: APIEndpoint,
        method: HTTPMethod = .GET,
        parameters: [String: Any]? = nil,
        headers: [String: String]? = nil
    ) -> AnyPublisher<T, Error> {
        guard let url = URL(string: endpoint.url) else {
            return Fail(error: NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
                .eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers

        if method == .POST || method == .PUT || method == .PATCH {
            do {
                if let parameters = parameters {
                    request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                }
            } catch {
                return Fail(error: error)
                    .eraseToAnyPublisher()
            }
        }

        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

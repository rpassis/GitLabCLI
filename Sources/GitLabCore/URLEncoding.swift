//
//  URLEncding.swift
//  GitLabCore
//
//  Created by Rogerio de Paula Assis on 1/16/19.
//

import Foundation

enum EncodingError: Error, LocalizedError {
    case urlNotFound

    var errorDescription: String? {
        switch self {
        case .urlNotFound:
            return NSLocalizedString("Unable to find URL in URLRequest", comment: "Unable to find URL")
        }
    }
}

struct URLEncoding {

    static let `default` = URLEncoding()

    func encode(_ urlRequest: URLRequest, parameters: Parameters?) throws -> URLRequest {
        guard let url = urlRequest.url else {
            throw(EncodingError.urlNotFound)
        }
        var urlRequest = urlRequest
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = parameters?.map { URLQueryItem(name: $0, value: "\($1)") }
        urlComponents?.queryItems = queryItems
        urlRequest.url = urlComponents?.url
        return urlRequest
    }
}

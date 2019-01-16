//
//  JSONEncoding.swift
//  GitLabCore
//
//  Created by Rogerio de Paula Assis on 1/16/19.
//

import Foundation

struct JSONEncoding {

    static let `default` = JSONEncoding()

    func encode(_ urlRequest: URLRequest, parameters: Parameters?) throws -> URLRequest {
        guard let parameters = parameters else { return urlRequest }
        var urlRequest = urlRequest
        let data = try JSONSerialization.data(withJSONObject: parameters, options: [])
        urlRequest.httpBody = data
        return urlRequest
    }
}

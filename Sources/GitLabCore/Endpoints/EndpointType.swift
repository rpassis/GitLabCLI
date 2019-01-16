//
//  Endpoint.swift
//  GitLabCore
//
//  Created by Rogerio de Paula Assis on 1/16/19.
//

import Foundation

typealias HTTPHeaders = [String: String]
typealias Parameters = [String: Any]

enum HTTPMethod: String {
    case options    = "OPTIONS"
    case get        = "GET"
    case head       = "HEAD"
    case post       = "POST"
    case put        = "PUT"
    case patch      = "PATCH"
    case delete     = "DELETE"
    case trace      = "TRACE"
    case connect    = "CONNECT"
}

protocol EndPointType {
    var baseURL: URL { get }
    var headers: HTTPHeaders? { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var path: String { get }
    func asURLRequest() throws -> URLRequest
}

extension EndPointType {
    var baseURL: URL {
        return Env.endpointURL
    }

    var headers: HTTPHeaders? {
        return nil
    }
}

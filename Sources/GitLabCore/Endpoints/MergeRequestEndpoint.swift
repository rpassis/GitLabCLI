//
//  MergeRequestEndpoint.swift
//  GitLabCore
//
//  Created by Rogerio de Paula Assis on 1/16/19.
//

import Foundation

enum MergeRequestEndpoint: EndPointType {

    case create(MergeRequest)
    case list(state: MergeRequest.State)

    var method: HTTPMethod {
        switch self {
        case .create: return .post
        case .list: return.get
        }
    }

    var parameters: Parameters? {
        switch self {
        case .list(let state):
            return [Key.state: state.rawValue]
        case .create(let mergeRequest):
            let removeSourceBranch = mergeRequest.remove_source_branch ?? false
            return [
                Key.title: mergeRequest.title,
                Key.sourceBranch: mergeRequest.source_branch,
                Key.targetBranch: mergeRequest.target_branch,
                Key.squash: mergeRequest.squash,
                Key.removeSourceBranch: removeSourceBranch
            ]
        }
    }

    var path: String {
        switch self {
        case .create, .list:
            return "/projects/\(Env.projectId)/merge_requests"
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        headers?.forEach { k, v in urlRequest.setValue(v, forHTTPHeaderField: k) }
        switch self {
        case .list:
            return try URLEncoding.default.encode(urlRequest, parameters: parameters)
        case .create:
            return try JSONEncoding.default.encode(urlRequest, parameters: parameters)
        }
    }

    private enum Key {
        static let title                    = "title"
        static let sourceBranch             = "source_branch"
        static let targetBranch             = "target_branch"
        static let squash                   = "squash"
        static let state                    = "state"
        static let removeSourceBranch       = "remove_source_branch"
    }


}

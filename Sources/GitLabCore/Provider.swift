//
//  Provider.swift
//  GitLabCore
//
//  Created by Rogerio de Paula Assis on 1/16/19.
//

import Foundation

var Env = Environment.current

public enum Provider {

    private static let network: Network = {
        var configuration = URLSessionConfiguration.default
        var additionalHeaders: HTTPHeaders = [
            Key.PrivateTokenKey: Env.gitlabToken,
            Key.ContentType: "application/json"
        ]        
        configuration.httpAdditionalHeaders = additionalHeaders
        let session = URLSession(configuration: configuration)
        return Network(session: session)
    }()

    public static func makeRepository() -> RepositoryType {
        return Repository(network: network)
    }

    private enum Key {
        static let PrivateTokenKey = "PRIVATE-TOKEN"
        static let ContentType = "Content-Type"
    }
}

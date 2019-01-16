//
//  Repository.swift
//  GitLabCore
//
//  Created by Rogerio de Paula Assis on 1/16/19.
//

import Foundation

public protocol RepositoryType {
    func createMergeRequest(source: String, target: String, title: String, then callback: @escaping ((MergeRequest?, Error?) -> Void))
    func listAll(then callback: @escaping (([MergeRequest]?, Error?) -> Void))
}

struct Repository: RepositoryType {

    private let network: Network
    init(network: Network) {
        self.network = network
    }

    func createMergeRequest(source: String, target: String, title: String, then callback: @escaping ((MergeRequest?, Error?) -> Void)) {
        let mergeRequest = MergeRequest(
            project_id: Env.projectId,
            source_branch: source,
            target_branch: target,
            title: title,
            squash: true,
            remove_source_branch: true,
            web_url: nil
        )
        let endpoint = MergeRequestEndpoint.create(mergeRequest)
        network.request(endpoint, then: callback)
    }

    func listAll(then callback: @escaping (([MergeRequest]?, Error?) -> Void)) {
        let endpoint = MergeRequestEndpoint.list
        network.request(endpoint, then: { (mergeRequests: [MergeRequest]?, error: Error?) in
            callback(mergeRequests, error)
        })
    }
}

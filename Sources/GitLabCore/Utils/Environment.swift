//
//  Environment.swift
//  GitLabCore
//
//  Created by Rogerio de Paula Assis on 1/16/19.
//

import Foundation

private func gitLabTokenFromEnvironment() -> String {
    return getEnvironmentVar(GitLabApiTokenEnvVar)
        .require(hint: "Unable to fetch \(GitLabApiTokenEnvVar) from environment variables.")
}

private func gitLabProjectIdFromEnvironment() -> Int {
    let projectIdString = getEnvironmentVar(GitLabProjectIdEnvVar).require()
    return Int(projectIdString)
        .require(hint: "Unable to fetch \(GitLabProjectIdEnvVar) from environment variables.")
}

private func gitLabProjectURLFromEnvironment() -> URL {
    let projectURLString = getEnvironmentVar(GitLabAPIURLEnvVar) ?? "https://gitlab.com/api/v4"
    return URL(string: projectURLString)
        .require(hint: "Unable to fetch \(GitLabAPIURLEnvVar) from environment variables.")
}

struct Environment {

    static var current = Environment()

    let gitlabToken: String
    let projectId: Int
    let endpointURL: URL

    init(
        gitlabToken: String = gitLabTokenFromEnvironment(),
        projectId: Int = gitLabProjectIdFromEnvironment(),
        endpointURL: URL = gitLabProjectURLFromEnvironment()) {
        self.gitlabToken = gitlabToken
        self.projectId = projectId
        self.endpointURL = endpointURL
    }

}

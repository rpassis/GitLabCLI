//
//  Environment.swift
//  GitLabCore
//
//  Created by Rogerio de Paula Assis on 1/16/19.
//

import Foundation

private let GitLabApiTokenEnvVar     = "GITLAB_API_TOKEN"
private let GitLabProjectIdEnvVar    = "GITLAB_PROJECT_ID"
private let GitLabAPIURLEnvVar       = "GITLAB_API_URL"

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

private func gitLabTokenFromEnvironment() -> String {
    guard let token = getEnvironmentVar(GitLabApiTokenEnvVar) else {
        print("Unable to fetch \(GitLabApiTokenEnvVar) from environment variables.")
        exit(EXIT_FAILURE)
    }
    return token
}

private func gitLabProjectIdFromEnvironment() -> Int {
    guard
        let projectIdString = getEnvironmentVar(GitLabProjectIdEnvVar),
        let projectId = Int(projectIdString) else {
            print("Unable to fetch \(GitLabProjectIdEnvVar) from environment variables.")
            exit(EXIT_FAILURE)
    }
    return projectId
}

private func gitLabProjectURLFromEnvironment() -> URL {
    let projectURLString = getEnvironmentVar(GitLabAPIURLEnvVar) ?? "https://gitlab.com/api/v4"
    guard let url = URL(string: projectURLString) else {
        print("Unable to fetch \(GitLabAPIURLEnvVar) from environment variables.")
        exit(EXIT_FAILURE)
    }
    return url
}

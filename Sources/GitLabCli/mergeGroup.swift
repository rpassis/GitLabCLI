//
//  mergeGroup.swift
//  GitLabCore
//
//  Created by Rogerio de Paula Assis on 1/16/19.
//

import Foundation
import Commander
import GitLabCore

func mergeGroup(_ group: Group, _ repo: RepositoryType) {
    group.group("merge", closure: { g in
        g.command(
            "create",
            Option("source_branch", default: Git.getCurrentBranchName(), description: "The source branch for the MR."),
            Option("target_branch", default: "develop", description: "The target branch for the MR"),
            Option("pr_title", default: Git.getHeadCommitMessage(), description: "The title for the MR")
        ) { source, target, title in
            repo.createMergeRequest(source: source, target: target, title: title) { mergeRequest, error in
                guard let mergeRequest = mergeRequest else {
                    let error = error ?? GitLabCliError.unknown
                    print("Error sending request: \(error.localizedDescription)")
                    exit(EXIT_FAILURE)
                }
                print("Pull request created at \n\(mergeRequest.web_url!)")
                exit(EXIT_SUCCESS)
            }
            dispatchMain()
        }
        g.command("list", {
            repo.listAll(then: { (mergeRequests, error) in
                guard let mergeRequests = mergeRequests else {
                    let error = error ?? GitLabCliError.unknown
                    print("Error sending request: \(error.localizedDescription)")
                    exit(EXIT_FAILURE)
                }
                print("Merge requests found:\n")
                mergeRequests.forEach {
                    let url = $0.web_url ?? ""
                    print("\($0.title) @ \(url)")
                }
                exit(EXIT_SUCCESS)
            })
            dispatchMain()
        })
    })
}

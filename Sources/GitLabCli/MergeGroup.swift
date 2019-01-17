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
                    exit(with: error); return
                }
                exit(withSuccessMessage: "Pull request created at \n\(mergeRequest.web_url!)")
            }
            dispatchMain()
        }
        
        g.command("list",
            Option("state", default: MergeRequest.State.opened.rawValue, description: "The state of the pull request - possible values are opened, closed, merged and locked.")
        ) { state in
            guard let state = MergeRequest.State(rawValue: state) else {
                exit(with: GitLabCliError.invalidOptions)
                return
            }
            repo.listAll(with: state, then: { mergeRequests, error in
                guard let mergeRequests = mergeRequests else {
                    exit(with: error); return
                }
                let successMessage = mergeRequests.reduce(into: [[String]](), { (result, mr) in
                    let row = [mr.title, mr.web_url ?? ""]
                    result.append(row)
                })
                exit(withSuccessMessage: successMessage)
            })
            dispatchMain()
        }
    })
}

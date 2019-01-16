//
//  ShellHelper.swift
//  GitLabCore
//
//  Created by Rogerio de Paula Assis on 1/16/19.
//

import Foundation

public enum Git {

    public static func getCurrentBranchName() -> String {
        // git rev-parse --symbolic-full-name --abbrev-ref HEAD)
        guard let branchName = run("/usr/bin/git", args: ["rev-parse", "--symbolic-full-name", "--abbrev-ref", "HEAD"]) else {
            print("Could not get the current branch name - make sure git is installed and that this is a git repository.")
            exit(EXIT_FAILURE)
        }
        return branchName
    }

    public static func getHeadCommitMessage() -> String {
        // git log --format=%B -n 1
        guard let commitMessage = run("/usr/bin/git", args: ["log", "--format=%B", "-n", "1"]) else {
            print("Could not get latest commit message - make sure git is installed and that this is a git repository.")
            exit(EXIT_FAILURE)
        }
        return commitMessage
    }
}

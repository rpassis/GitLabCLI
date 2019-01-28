//
//  mergeGroup.swift
//  GitLabCore
//
//  Created by Rogerio de Paula Assis on 1/16/19.
//

import Foundation
import Guaka
import GitLabCore

/* /merge_requests endpoint */

class MergeRequests: CommandConvertible {

    required init() {}
    
    func asCommand() -> Command {
        let projectIDFlag = Flag(
            longName: "project-id",
            type: Int.self,
            description: "The id of the target project.",
            required: false,
            inheritable: true
        )
        let main = Command(usage: "merge-requests", flags: [projectIDFlag]) { flags, _ in
            let projectID = flags.getInt(name: "project-id") ?? Environment.current.projectId
            print("ProjectID is \(projectID)")
        }
        main.add(subCommands: [list, create])
        return main
    }
}

extension MergeRequests {

    private var list: Command {
        let requestId = Flag(
            shortName: "id",
            longName: "merge-request-id",
            type: Int.self,
            description: "Shows information about a single merge request.",
            required: false
        )
        let listMergeRequests = Flag(
            shortName: "a",
            longName: "all",
            value: false,
            description: "Get all merge requests for the specified project."
        )

        return Command(usage: "list", flags: [requestId, listMergeRequests]) { _, _ in

        }
    }

    private var create: Command {
        return Command(usage: "create") { _, _ in

        }
    }

}


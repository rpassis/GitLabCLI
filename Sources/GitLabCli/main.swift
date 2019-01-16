import Foundation
import GitLabCore
import Commander

let repo = Provider.makeRepository()

enum GitLabCliError: LocalizedError {
    case unknown

    var errorDescription: String? {
        return NSLocalizedString("Unknown error", comment: "Unknown error")
    }
}

let main = Group { g in
    mergeGroup(g, repo)
}

main.run()

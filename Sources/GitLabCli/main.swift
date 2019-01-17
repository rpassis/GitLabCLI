import Foundation
import GitLabCore
import Commander

let repo = Provider.makeRepository()

let main = Group { g in
    mergeGroup(g, repo)
}

main.run()

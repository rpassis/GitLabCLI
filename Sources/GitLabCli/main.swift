import Foundation
import GitLabCore
import Guaka

let versionFlag = Flag(longName: "version", value: false, description: "Prints the version number")
let apiTokenFlag = Flag(
    longName: "api-token",
    type: String.self,
    description: "The authentication token to be used for all requests",
    required: false,
    inheritable: true
)

let command = Command(usage: "help", flags: [versionFlag, apiTokenFlag]) { flags, _ in
    print("GitLab Command Line Interface v0.0.1")
    print("Use \"gitlab-cli --help\" for all the possible commands.")
    let token = flags.getString(name: "api-token") ?? "Not set"
    print("API Token is \(token)")
}

command.add(subCommands: [MergeRequests.self])
command.execute()

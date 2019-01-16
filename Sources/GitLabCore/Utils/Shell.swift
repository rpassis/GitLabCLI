//
//  Shell.swift
//  GitLabCore
//
//  Created by Rogerio de Paula Assis on 1/16/19.
//

import Foundation

public func run(_ launchPath: String, args: [String]) -> String? {
    let task = Process()
    let pipe = Pipe()
    task.launchPath = launchPath
    task.arguments = args
    task.standardOutput = pipe
    let handle = pipe.fileHandleForReading
    task.launch()
    return String(data: handle.readDataToEndOfFile(), encoding: .utf8)?
        .replacingOccurrences(of: "\n", with: "")
}

func getEnvironmentVar(_ name: String) -> String? {
    guard let rawValue = getenv(name) else { return nil }
    return String(utf8String: rawValue)
}

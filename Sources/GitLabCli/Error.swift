//
//  Error.swift
//  GitLabCli
//
//  Created by Rogerio de Paula Assis on 1/16/19.
//

import Foundation

enum GitLabCliError: LocalizedError {
    case unknown
    case invalidOptions

    var errorDescription: String? {
        switch self {
        case .unknown:
            return NSLocalizedString("Unknown error", comment: "Unknown error")
        case .invalidOptions:
            return NSLocalizedString("Invalid options", comment: "Invalid options")
        }
    }
}

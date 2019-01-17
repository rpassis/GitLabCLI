//
//  Util.swift
//  GitLabCli
//
//  Created by Rogerio de Paula Assis on 1/16/19.
//

import Foundation

func exit(with error: Error?) {
    let error = error ?? GitLabCliError.unknown
    print(error.localizedDescription)
    exit(EXIT_FAILURE)
}

func exit(withSuccessMessage message: String) {
    print(message)
    exit(EXIT_SUCCESS)
}

func exit(withSuccessMessage message: [[String]]) {
    print(message)
    exit(EXIT_SUCCESS)
}

private func print(_ table: [[String]], column: Int = 120) {
    let maxColumns = table.reduce(into: 0) { (max, row) in
        if row.count > max { max = row.count }
    }
    let separator = " | "
    let charsPerColumn = column/maxColumns - separator.count
    let divider = String(repeating: "=", count: column)
    print(divider)
    table.forEach { row in
        let rowMessage = row.map { column -> String in
            var column = column.prefix(charsPerColumn)
            let paddingRequired = charsPerColumn - column.count
            if paddingRequired > 0 {
                column += String(repeating: " ", count: paddingRequired)
            }
            return String(column + separator)
        }.joined()
        print("| " + rowMessage)
    }
    print(divider)
}

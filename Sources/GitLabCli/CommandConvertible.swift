//
//  CommandConvertible.swift
//  gitlab-cli
//
//  Created by Rogerio de Paula Assis on 1/28/19.
//

import Foundation
import Guaka

protocol CommandConvertible {
    init()
    func asCommand() -> Command
}

extension Command {

    func add(subCommands: [CommandConvertible.Type]) {
        let commands = subCommands.map { C -> Command in
            let c = C.init()
            return c.asCommand()
        }
        add(subCommands: commands)
    }
    
}

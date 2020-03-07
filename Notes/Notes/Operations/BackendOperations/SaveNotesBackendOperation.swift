//
//  SaveNotesBackendOperation.swift
//  Notes
//
//  Created by Денис Домашевич on 2/26/20.
//  Copyright © 2020 Денис Домашевич. All rights reserved.
//

import Foundation

enum NetworkError {
    case unreachable
}

enum SaveNotesBackendResult {
    case success
    case failure(NetworkError)
}

let token = "5a956ffbb7b993d2794a2cf03a84f36750cdf2c3"
let api = "https://api.github.com/gists"

class SaveNotesBackendOperation: BaseBackendOperation {
    
    private(set) var result: SaveNotesBackendResult?
    
    init(notes: [Note]) {
        super.init()
    }
    
    override func main() {
        result = .failure(.unreachable)
        finish()
    }    
    
}


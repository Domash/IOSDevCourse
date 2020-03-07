//
//  LoadNotesBackendOperation.swift
//  Notes
//
//  Created by Денис Домашевич on 2/26/20.
//  Copyright © 2020 Денис Домашевич. All rights reserved.
//

import Foundation

enum LoadNotesBackendResult {
    case success([Note])
    case failure(NetworkError)
}

class LoadNotesBackendOperation: BaseBackendOperation {
    
    private(set) var result: LoadNotesBackendResult?
    
    override init() {
        super.init()
    }
    
    override func main() {
        
        loadGists()
        //print(gists)
        
        result = .failure(.unreachable)
        finish()
    }

}

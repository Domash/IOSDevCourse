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
    
    private let network: NetworkStuff = NetworkStuff()
    
    override init() {
        super.init()
    }
    
    override func main() {
                
        let semaphore = DispatchSemaphore(value: 0)
        
        func completionGistExist(value: Bool) {
            if value {
                network.loadGistContent(completion: completionLoadNotes)
            } else {
                result = .failure(.unreachable)
                finish()
            }
        }
        
        func completionLoadNotes(value: [Note]) {
            result = .success(value)
            semaphore.signal()
        }
        
        network.loadGists(completion: completionGistExist)
        
        semaphore.wait()
        
        finish(string: "LoadNotesBackendOperation")
        
    }

}

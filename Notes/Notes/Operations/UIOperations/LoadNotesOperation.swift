//
//  LoadNotesOperation.swift
//  Notes
//
//  Created by Денис Домашевич on 2/26/20.
//  Copyright © 2020 Денис Домашевич. All rights reserved.
//

import Foundation

class LoadNotesOperation: AsyncOperation {
    
    private let loadFromDb: LoadNotesDBOperation
    private let loadFromBackend: LoadNotesBackendOperation
    
    private(set) var result: [Note]? = []
    
    init(
        notebook: FileNotebook,
        backendQueue: OperationQueue,
        dbQueue: OperationQueue
    ) {
        
        loadFromBackend = LoadNotesBackendOperation()
        loadFromDb = LoadNotesDBOperation(notebook: notebook)
        
        super.init()
        
        loadFromBackend.completionBlock = {
            switch self.loadFromBackend.result! {
            case .success(let notes):
                self.result = notes
            case .failure:
                backendQueue.addOperation(self.loadFromDb)
            }
        }
        
        addDependency(loadFromBackend)
        addDependency(loadFromDb)
        backendQueue.addOperation(loadFromBackend)
        
    }
    
    override func main() {
        
        if let notes = loadFromDb.result {
            result = notes
        }
 
        finish()
        
    }
    
}

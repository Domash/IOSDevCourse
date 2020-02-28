//
//  RemoveNoteOperation.swift
//  Notes
//
//  Created by Денис Домашевич on 2/26/20.
//  Copyright © 2020 Денис Домашевич. All rights reserved.
//

import Foundation

class RemoveNoteOperation: AsyncOperation {
    
    private let removeFromDb: RemoveNoteDBOperation
    private let saveToBackend: SaveNotesBackendOperation
    
    private(set) var result: Int? = -1
    
    init(
        noteId: String,
        notebook: FileNotebook,
        backendQueue: OperationQueue,
        dbQueue: OperationQueue
    ) {
        
        removeFromDb = RemoveNoteDBOperation(noteId: noteId, notebook: notebook)
        saveToBackend = SaveNotesBackendOperation(notes: notebook.notes)
        
        super.init()
        
        removeFromDb.completionBlock = {
            backendQueue.addOperation(self.saveToBackend)
        }
        
        addDependency(removeFromDb)
        addDependency(saveToBackend)
        
        dbQueue.addOperation(removeFromDb)
        
    }
    
    override func main() {
        
        if let index = removeFromDb.result {
            if index >= 0 {
                result = index
            }
        }
        
    }
    
}

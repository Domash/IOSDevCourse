//
//  SaveNoteOperation.swift
//  Notes
//
//  Created by Денис Домашевич on 2/26/20.
//  Copyright © 2020 Денис Домашевич. All rights reserved.
//

import Foundation

class SaveNoteOperation: AsyncOperation {
    
    private let saveToDb: SaveNoteDBOperation
    private let saveToBackend: SaveNotesBackendOperation
    
    private(set) var result: Bool? = false
    
    init(
        note: Note,
        notebook: FileNotebook,
        backendQueue: OperationQueue,
        dbQueue: OperationQueue
    ) {
        
        saveToDb = SaveNoteDBOperation(note: note, notebook: notebook)
        saveToBackend = SaveNotesBackendOperation(notes: notebook.notes)

        super.init()
        
        saveToDb.completionBlock = {
            backendQueue.addOperation(self.saveToBackend)
        }
        
        addDependency(saveToDb)
        addDependency(saveToBackend)
        dbQueue.addOperation(saveToDb)
        
    }
    
    override func main() {
        
        if let result = saveToBackend.result {
            switch result {
            case .success:
                self.result = true
            case .failure:
                self.result = false
            }
        }
        
        finish()
        
    }
    
}


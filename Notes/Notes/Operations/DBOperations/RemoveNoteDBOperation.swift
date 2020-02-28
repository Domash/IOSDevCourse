//
//  RemoveNoteDBOperation.swift
//  Notes
//
//  Created by Денис Домашевич on 2/26/20.
//  Copyright © 2020 Денис Домашевич. All rights reserved.
//

import Foundation

class RemoveNoteDBOperation: BaseDBOperation {
    
    private let noteId: String
    private(set) var result: Int?
    
    
    init(
        noteId: String,
        notebook: FileNotebook
    ) {
        self.noteId = noteId
        super.init(notebook: notebook)
    }
    
    override func main() {
        result = notebook.remove(with: noteId)
        notebook.saveToFile()
        finish()
    }
    
}

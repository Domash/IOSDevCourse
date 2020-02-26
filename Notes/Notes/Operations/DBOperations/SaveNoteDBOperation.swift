//
//  SaveNoteDBOperation.swift
//  Notes
//
//  Created by Денис Домашевич on 2/26/20.
//  Copyright © 2020 Денис Домашевич. All rights reserved.
//

import Foundation

class SaveNoteDBOperation: BaseDBOperation {
    
    private let note: Note
    
    init(
        note: Note,
        notebook: FileNotebook
    ) {
        self.note = note
        super.init(notebook: notebook)
    }
    
    override func main() {
        notebook.add(note)
        notebook.saveToFile()
        finish()
    }
    
}


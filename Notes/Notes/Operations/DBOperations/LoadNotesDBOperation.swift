//
//  LoadNotesDBOperation.swift
//  Notes
//
//  Created by Денис Домашевич on 2/26/20.
//  Copyright © 2020 Денис Домашевич. All rights reserved.
//

import Foundation

class LoadNotesDBOperation: BaseDBOperation {
    
    private(set) var result: [Note]?
    
    override init(
        notebook: FileNotebook
    ) {
        super.init(notebook: notebook)
    }
    
    override func main() {
        notebook.loadFromFile()
        result = notebook.notes
        finish(string: "LoadNotesDBOperation")
    }
    
}

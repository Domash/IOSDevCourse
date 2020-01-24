//
//  FileNotebook.swift
//  Notes
//
//  Created by Денис Домашевич on 1/24/20.
//  Copyright © 2020 Денис Домашевич. All rights reserved.
//

import UIKit

class FileNotebook {
    
    private enum FileNotebookError: String, Error {
        case noteAlreadyExists = "Note already exists!"
    }
    
    private(set) var notes = [String: Note]()
    
    public func add(_ note: Note) throws {
        guard notes[note.uid] != nil else {
            notes[note.uid] = note
            return
        }
        throw FileNotebookError.noteAlreadyExists
    }
    
    public func remove(with uid: String) {
        notes.removeValue(forKey: uid)
    }
    
    public func saveToFile() {
        if let dirPath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first {
            do {
                let jsonArr = notes.map { $0.value.json }
                let data = try JSONSerialization.data(withJSONObject: jsonArr, options: [])
                let pathUrl = dirPath.appendingPathComponent("notes.json")
                FileManager.default.createFile(atPath: pathUrl.path, contents: data, attributes: nil)
            } catch let error {
                print("Can't save notes to: \(error.localizedDescription)!")
            }
        }
    }
    
    public func loadFromFile() {
        notes.removeAll()
        if let dirPath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first {
            do {
                let pathUrl = dirPath.appendingPathComponent("notes.json")
                if let data = FileManager.default.contents(atPath: pathUrl.path),
                   let jsonNotes = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    for jsonNote in jsonNotes {
                        if let note = Note.parse(json: jsonNote) {
                            try self.add(note)
                        }
                    }
                } else {
                    print("Can't load notes!")
                }
            } catch let error {
                print("Can't load notes from: \(error.localizedDescription)!")
            }
        }
    }
    
}

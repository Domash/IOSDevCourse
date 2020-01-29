//
//  FileNotebook.swift
//  Notes
//
//  Created by Денис Домашевич on 1/24/20.
//  Copyright © 2020 Денис Домашевич. All rights reserved.
//

import UIKit

class FileNotebook {
    
    public enum FileNotebookError: String, Error {
        case noteAlreadyExists = "Note already exists!"
    }
    
    private static let cachesFile = "notes.json"
    private static let cachesDirPath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
    
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
        let dirPath = FileNotebook.cachesDirPath!
        do {
            let jsonArr = notes.map { $0.value.json }
            let data = try JSONSerialization.data(withJSONObject: jsonArr, options: [])
            let pathUrl = dirPath.appendingPathComponent(FileNotebook.cachesFile)
            FileManager.default.createFile(atPath: pathUrl.path, contents: data, attributes: nil)
        } catch let error {
            print("Can't save notes to: \(error.localizedDescription)!")
        }
    }
    
    public func loadFromFile() {
        notes.removeAll()
        let dirPath = FileNotebook.cachesDirPath!
        do {
            let pathUrl = dirPath.appendingPathComponent(FileNotebook.cachesFile)
            if let data = FileManager.default.contents(atPath: pathUrl.path) {
                if let jsonNotes = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    for jsonNote in jsonNotes {
                        if let note = Note.parse(json: jsonNote) {
                            try self.add(note)
                        }
                    }
                } else {
                    // Log ...
                }
            } else {
                // Log ...
            }
        } catch let error {
            print("Can't load notes from: \(error.localizedDescription)!")
        }
    }
    
}

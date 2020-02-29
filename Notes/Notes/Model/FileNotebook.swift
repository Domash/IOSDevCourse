//
//  FileNotebook.swift
//  Notes
//
//  Created by Денис Домашевич on 1/24/20.
//  Copyright © 2020 Денис Домашевич. All rights reserved.
//

import UIKit
import CocoaLumberjack

class FileNotebook {
    
    public enum FileNotebookError: String, Error {
        case noteAlreadyExists = "Note already exists!"
    }
    
    private static let cachesFile = "notes.json"
    private static let cachesDirPath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
    
    private(set) var notes: [Note] = []
    
    public func add(_ note: Note) {
        if let index: Int = notes.firstIndex(where: {$0.uid == note.uid}) {
            notes[index] = note
            // DDLogInfo("Note with id = [\(note.uid)] could not be added, note with this uuid already exists. Index = [\(index)!")
            // throw FileNotebookError.noteAlreadyExists
        } else {
            notes.append(note)
            DDLogInfo("Note with id = [\(note.uid)] is added.")
        }
    }
    
    public func remove(with uid: String) -> Int {
        if let index: Int = notes.firstIndex(where: {$0.uid == uid}) {
            notes.remove(at: index)
            DDLogInfo("Note with id = [\(uid)] is removed.")
            return index
        }
        return -1
    }
    
    public func update(forNotes notes: [Note]) {
        self.notes = notes
        saveToFile()
    }
    
    public func saveToFile() {
        let dirPath = FileNotebook.cachesDirPath!
        do {
            let jsonArr = notes.map { $0.json }
            let data = try JSONSerialization.data(withJSONObject: jsonArr, options: [])
            let pathUrl = dirPath.appendingPathComponent(FileNotebook.cachesFile)
            FileManager.default.createFile(atPath: pathUrl.path, contents: data, attributes: nil)
            DDLogInfo("Notes are saved to file.")
        } catch let error {
            DDLogError("Can't save notes to: \(error.localizedDescription)!")
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
                            self.add(note)
                        }
                    }
                    DDLogInfo("Notes are load from file file.")
                } else {
                    DDLogInfo("Can't serialize objects.")
                }
            } else {
                DDLogInfo("Can't open file by path.")
            }
        } catch let error {
            DDLogError("Can't load notes from: \(error.localizedDescription)!")
        }
    }
    
}

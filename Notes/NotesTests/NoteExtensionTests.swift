//
//  NoteExtensionTests.swift
//  NotesTests
//
//  Created by Денис Домашевич on 2/3/20.
//  Copyright © 2020 Денис Домашевич. All rights reserved.
//

import XCTest
@testable import Notes

class NoteExtensionTests: XCTestCase {
    
    var baseNote: Note?
    var fullNote: Note?
    
    var baseNoteJson: [String: Any]!
    var fullNoteJson: [String: Any]!
    
    override func setUp() {
        
        baseNote = Note(title: "Title", content: "Content")
        fullNote = Note(uid: UUID().uuidString, title: "Title", content: "Content", color: .cyan, importance: Importance.important, selfDestructionDate: Date().addingTimeInterval(322228))
        
        baseNoteJson = baseNote?.json
        fullNoteJson = fullNote?.json
        
        baseNote = Note.parse(json: baseNoteJson)
        fullNote = Note.parse(json: fullNoteJson)
        
    }
    
    func testParseCorrectNote() {
        XCTAssertNotNil(fullNoteJson["uid"])
        XCTAssertNotNil(fullNoteJson["title"])
        XCTAssertNotNil(fullNoteJson["content"])
        XCTAssertNotNil(fullNoteJson["color"])
        XCTAssertNotNil(fullNoteJson["importance"])
        XCTAssertNotNil(fullNoteJson["selfDestructionDate"])
    }
    
    func testParseWithoutColor() {
        XCTAssertEqual(UIColor.white, baseNote?.color)
    }
    
    func testParseWithoutDate() {
        XCTAssertNil(baseNote?.selfDestructionDate)
    }
    
    func testParseWithoutRequiredFields() {
        baseNoteJson.removeValue(forKey: "title")
        XCTAssertNil(Note.parse(json: baseNoteJson))
        baseNoteJson["title"] = "Title"
    }
    
    func testParseCorrectType() {
        baseNoteJson["title"] = 20
        XCTAssertNil(Note.parse(json: baseNoteJson))
        baseNoteJson["title"] = "Title"
    }
    
}

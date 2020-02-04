//
//  NoteExtensionTests.swift
//  NotesTests
//
//  Created by Денис Домашевич on 2/3/20.
//  Copyright © 2020 Денис Домашевич. All rights reserved.
//

import XCTest
@testable import Notes

// Nimble
// Quick
// Charlies
// erorr enum

class NoteExtensionTests: XCTestCase {
    
    override func setUp() {
    }

    func testParseCorrectNote() {
        let note = Note(
            uid: UUID().uuidString,
            title: "Title",
            content: "Content",
            color: UIColor.cyan,
            importance: Importance.important,
            selfDestructionDate: Date().addingTimeInterval(322228)
        )
        
        let noteJson = note.json
        let parsedNote = Note.parse(json: noteJson)
        
        XCTAssertEqual(parsedNote?.uid, note.uid)
        XCTAssertEqual(parsedNote?.title, note.title)
        XCTAssertEqual(parsedNote?.content, note.content)
        XCTAssertEqual(parsedNote?.color, note.color)
        XCTAssertEqual(parsedNote?.importance, note.importance)
        XCTAssertEqual(parsedNote?.selfDestructionDate?.timeIntervalSince1970,
                       note.selfDestructionDate?.timeIntervalSince1970)
    }

    func testParseWithoutColor() {
        let note = Note(
            uid: UUID().uuidString,
            title: "Title",
            content: "Content",
            importance: Importance.important,
            selfDestructionDate: Date().addingTimeInterval(322228)
        )
        
        let noteJson = note.json
        let parsedNote = Note.parse(json: noteJson)
        
        XCTAssertEqual(parsedNote?.uid, note.uid)
        XCTAssertEqual(parsedNote?.title, note.title)
        XCTAssertEqual(parsedNote?.content, note.content)
        XCTAssertEqual(parsedNote?.color, UIColor.white)
        XCTAssertEqual(parsedNote?.importance, note.importance)
        XCTAssertEqual(parsedNote?.selfDestructionDate?.timeIntervalSince1970,
                       note.selfDestructionDate?.timeIntervalSince1970)
    }

    func testParseWithoutDate() {
        let note = Note(
            uid: UUID().uuidString,
            title: "Title",
            content: "Content",
            importance: Importance.important
        )
        
        let noteJson = note.json
        let parsedNote = Note.parse(json: noteJson)
        
        XCTAssertNil(parsedNote?.selfDestructionDate)
    }

    func testParseWithoutRequiredFieldTitle() {
        let note = Note(
            title: "Title",
            content: "Content"
        )
        
        var noteJson = note.json
        noteJson["Title"] = "Title"
        noteJson.removeValue(forKey: "title")
        
        let parsedNote = Note.parse(json: noteJson)
        
        XCTAssertNil(parsedNote)
    }

    func testParseWithoutRequiredFieldContent() {
        let note = Note(
            title: "Title",
            content: "Content"
        )
        
        var noteJson = note.json
        noteJson["Content"] = "Content"
        noteJson.removeValue(forKey: "content")
        
        let parsedNote = Note.parse(json: noteJson)
        
        XCTAssertNil(parsedNote)
    }
    
    func testParseWithTypoInJsonKeyTitle() {
        let note = Note(
            title: "Title",
            content: "Content"
        )
        
        var noteJson = note.json
        noteJson["tile"] = "Title"
        noteJson.removeValue(forKey: "title")
        
        let parsedNote = Note.parse(json: noteJson)
        
        XCTAssertNil(parsedNote)
    }
    
    func testParseWithTypoInJsonKeyContent() {
        let note = Note(
            title: "Title",
            content: "Content"
        )
        
        var noteJson = note.json
        noteJson["conten"] = "Content"
        noteJson.removeValue(forKey: "content")
        
        let parsedNote = Note.parse(json: noteJson)
        
        XCTAssertNil(parsedNote)
    }

    func testParseCorrectTypeTitle() {
        let note = Note(
            title: "Title",
            content: "Content"
        )
        
        var noteJson = note.json
        noteJson["title"] = 100
        
        let parsedNote = Note.parse(json: noteJson)
        
        XCTAssertNil(parsedNote)
    }
    
    func testParseCorrectTypeContent() {
        let note = Note(
            title: "Title",
            content: "Content"
        )
        
        var noteJson = note.json
        noteJson["content"] = 100
        
        let parsedNote = Note.parse(json: noteJson)
        
        XCTAssertNil(parsedNote)
    }
    
}

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
    
//    var baseNote: Note?
//    var fullNote: Note?
//
//    var baseNoteJson: [String: Any]!
//    var fullNoteJson: [String: Any]!
//
//    override func setUp() {
//
//        baseNote = Note(title: "Title", content: "Content")
//        fullNote = Note(uid: UUID().uuidString, title: "Title", content: "Content", color: .cyan, importance: Importance.important, selfDestructionDate: Date().addingTimeInterval(322228))
//
//        baseNoteJson = baseNote?.json
//        fullNoteJson = fullNote?.json
//
//        let parsedBaseNote = Note.parse(json: baseNoteJson)
//        let parsedFullNote = Note.parse(json: fullNoteJson)
//
//        baseNoteJson = baseNote?.json
//        fullNoteJson = fullNote?.json
//
//    }
//
//    func testParseCorrectNote() {
//        XCTAssertNotNil(fullNoteJson["uid"])
//        XCTAssertNotNil(fullNoteJson["title"])
//        XCTAssertNotNil(fullNoteJson["content"])
//        XCTAssertNotNil(fullNoteJson["color"])
//        XCTAssertNotNil(fullNoteJson["importance"])
//        XCTAssertNotNil(fullNoteJson["selfDestructionDate"])
//    }
//
//    func testParseWithoutColor() {
//        XCTAssertEqual(UIColor.white, baseNote?.color)
//    }
//
//    func testParseWithoutDate() {
//        XCTAssertNil(baseNote?.selfDestructionDate)
//    }
//
//    func testParseWithoutRequiredFields() {
//        baseNoteJson.removeValue(forKey: "title")
//        XCTAssertNil(Note.parse(json: baseNoteJson))
//        baseNoteJson["title"] = "Title"
//
//        baseNoteJson.removeValue(forKey: "content")
//        XCTAssertNil(Note.parse(json: baseNoteJson))
//        baseNoteJson["content"] = "Content"
//
//        if let uid = baseNoteJson["uid"] {
//            baseNoteJson.removeValue(forKey: "uid")
//            XCTAssertNil(Note.parse(json: baseNoteJson))
//            baseNoteJson["uid"] = uid
//        }
//    }
//
//    func testParseWithTypoInJsonKeys() {
//        baseNoteJson["Title"] = "Title"
//        baseNoteJson.removeValue(forKey: "title")
//        XCTAssertNil(Note.parse(json: baseNoteJson))
//        baseNoteJson.removeValue(forKey: "Title")
//        baseNoteJson["title"] = "Title"
//
//        baseNoteJson["Content"] = "Content"
//        baseNoteJson.removeValue(forKey: "content")
//        XCTAssertNil(Note.parse(json: baseNoteJson))
//        baseNoteJson.removeValue(forKey: "Content")
//        baseNoteJson["content"] = "Content"
//
//        if let uid = baseNoteJson["uid"] {
//            baseNoteJson["Uid"] = uid
//            baseNoteJson.removeValue(forKey: "uid")
//            XCTAssertNil(Note.parse(json: baseNoteJson))
//            baseNoteJson.removeValue(forKey: "Uid")
//            baseNoteJson["uid"] = uid
//        }
//    }
//
//    func testParseCorrectType() {
//        baseNoteJson["title"] = 228
//        XCTAssertNil(Note.parse(json: baseNoteJson))
//        baseNoteJson["title"] = "Title"
//
//        baseNoteJson["content"] = 228
//        XCTAssertNil(Note.parse(json: baseNoteJson))
//        baseNoteJson["content"] = "Content"
//
//        if let uid = baseNoteJson["uid"] {
//            baseNoteJson["uid"] = 228
//            XCTAssertNil(Note.parse(json: baseNoteJson))
//            baseNoteJson["uid"] = uid
//        }
//    }
    
}

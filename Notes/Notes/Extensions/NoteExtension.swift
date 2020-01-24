//
//  NoteExtension.swift
//  Notes
//
//  Created by Денис Домашевич on 1/24/20.
//  Copyright © 2020 Денис Домашевич. All rights reserved.
//

import UIKit

extension Note {

    private enum ColorKeys {
        static let red = "red"
        static let green = "green"
        static let blue = "blue"
        static let alpha = "alpha"
    }
    
    private enum JsonKeys {
        static let uid = "uid"
        static let title = "title"
        static let content = "content"
        static let color = "color"
        static let importance = "importance"
        static let selfDestructionDate = "selfDestructionDate"
    }
        
    var json: [String: Any] {
        var resultJson: [String: Any] = [
            JsonKeys.uid: uid,
            JsonKeys.title: title,
            JsonKeys.content: content
        ]
        
        if color != UIColor.white {
            resultJson[JsonKeys.color] = Note.colorToDict(color)
        }
        
        if importance != Importance.common {
            resultJson[JsonKeys.importance] = importance.rawValue
        }
        
        resultJson[JsonKeys.selfDestructionDate] = selfDestructionDate?.timeIntervalSince1970
        
        return resultJson
    }
    
    static func parse(json: [String: Any]) -> Note? {
        guard
          let uid = json[JsonKeys.uid] as? String,
          let title = json[JsonKeys.title] as? String,
          let content = json[JsonKeys.content] as? String
        else {
            return nil
        }
        
        let color = getColorFromJson(json)
        let importance = getImportanceFromJson(json)
        let selfDestructionDate = getDateFromJson(json)
        
        return Note(uid: uid,
                    title: title,
                    content: content,
                    color: color,
                    importance: importance,
                    selfDestructionDate: selfDestructionDate)
    }
    
    private static func getImportanceFromJson(_ json: [String: Any]) -> Importance {
        if let importance = json[JsonKeys.importance] as? String {
            return Importance(rawValue: importance) ?? Importance.common
        }
        return Importance.common
    }
    
    private static func getDateFromJson(_ json: [String: Any]) -> Date? {
        if let timeInterval = json[JsonKeys.selfDestructionDate] as? TimeInterval {
            return Date(timeIntervalSince1970: timeInterval)
        }
        return nil
    }
    
    private static func getColorFromJson(_ json: [String: Any]) -> UIColor {
        guard let colorDict = json[JsonKeys.color] as? [String: Double] else {
            return UIColor.white
        }
        
        guard
          let r = colorDict[ColorKeys.red],
          let g = colorDict[ColorKeys.green],
          let b = colorDict[ColorKeys.blue],
          let a = colorDict[ColorKeys.alpha]
        else {
            return UIColor.white
        }
        
        return UIColor(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: CGFloat(a))
    }
    
    private static func colorToDict(_ color: UIColor) -> [String: Double] {
        var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        return [
            ColorKeys.red: Double(r),
            ColorKeys.green: Double(g),
            ColorKeys.blue: Double(b),
            ColorKeys.alpha: Double(a)
        ]
    }
    
}


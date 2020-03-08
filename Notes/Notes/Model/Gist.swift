//
//  Gist.swift
//  Notes
//
//  Created by Денис Домашевич on 3/8/20.
//  Copyright © 2020 Денис Домашевич. All rights reserved.
//

import Foundation

struct Gist: Codable {
    let id: String
    let files: [String: GistFile]
}

struct GistFile: Codable {
    let filename: String
    let rawUrl: String
    
    enum CodingKeys: String, CodingKey {
        case filename
        case rawUrl = "raw_url"
    }
}

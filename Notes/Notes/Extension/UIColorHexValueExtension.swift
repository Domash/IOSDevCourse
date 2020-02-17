//
//  UIColorHexValueExtension.swift
//  Notes
//
//  Created by Денис Домашевич on 2/17/20.
//  Copyright © 2020 Денис Домашевич. All rights reserved.
//

import UIKit

extension UIColor {
    public var hexValue: String {
        guard let components = self.cgColor.components else {
            return "#FFFFFF"
        }
        return String(
            format: "#%02X%02X%02X",
            Int(components[0] * 255.0),
            Int(components[1] * 255.0),
            Int(components[2] * 255.0)
        )
    }
}

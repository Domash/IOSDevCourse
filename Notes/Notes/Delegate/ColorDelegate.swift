//
//  ColorDelegate.swift
//  Notes
//
//  Created by Денис Домашевич on 2/17/20.
//  Copyright © 2020 Денис Домашевич. All rights reserved.
//

import UIKit.UIColor

protocol Colorable: AnyObject {
    func passValue(of color: UIColor)
    func passValue(of coordinates: CGPoint, and brightness: Float)
}

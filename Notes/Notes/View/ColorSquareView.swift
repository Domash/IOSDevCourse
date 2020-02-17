//
//  ColorSquareView.swift
//  Notes
//
//  Created by Денис Домашевич on 2/10/20.
//  Copyright © 2020 Денис Домашевич. All rights reserved.
//

import UIKit

class ColorSquareView: UIView {
    
    @IBInspectable var isSelected: Bool = false
    @IBInspectable var isGradient: Bool = false
    @IBInspectable var isRoundedCorners: Bool = false
    @IBInspectable var borderWidth: CGFloat = 0
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if isSelected {
            setMark(rect)
        }
        if isRoundedCorners {
            clipsToBounds = true
            layer.cornerRadius = 11
        }
        layer.borderWidth = borderWidth
        layer.borderColor = UIColor.black.cgColor
    }
    
    private func setMark(_ rect: CGRect) {
        let path = UIBezierPath(rect: rect)
        path.move(to: CGPoint(x: rect.midX, y: rect.midY + 8))
        path.addLine(to: CGPoint(x: rect.midX - 7, y: rect.midY - 2))
        path.move(to: CGPoint(x: rect.midX, y: rect.midY + 8))
        path.addLine(to: CGPoint(x: rect.midX + 8, y: rect.midY - 8))
        if backgroundColor == UIColor.black {
            UIColor.white.setStroke()
        }
        path.stroke()
    }
}

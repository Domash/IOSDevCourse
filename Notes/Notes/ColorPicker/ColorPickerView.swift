//
//  ColorPickerView.swift
//  Notes
//
//  Created by Денис Домашевич on 2/10/20.
//  Copyright © 2020 Денис Домашевич. All rights reserved.
//

import UIKit

class ColorPickerView: UIView {
    
    @IBInspectable var borderWidth: CGFloat = 0
    
    static let colorSpace = CGColorSpaceCreateDeviceRGB()
    
    private var dimmingValue: CGFloat = 1.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var dimming: Float {
        set {
            dimmingValue = CGFloat(newValue)
        }
        get {
            return Float(dimmingValue)
        }
    }
    
    private var x: CGFloat = 0.0
    private var y: CGFloat = 0.0
    
    var cursorPosition: (CGFloat, CGFloat) {
        set {
            x = newValue.0
            y = newValue.1
            setNeedsDisplay()
        }
        get {
            return (x, y)
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        ColorPickerView.gradientBackground(for: self, with: rect)
        dimmingBackground(for: dimmingValue)
        drawPicker(x: x, y: y)
        layer.borderWidth = borderWidth
        layer.borderColor = UIColor.black.cgColor
    }
    
    private func drawPicker(x: CGFloat, y: CGFloat) {
        let path = UIBezierPath(
            arcCenter: CGPoint(x: x, y: y),
            radius: 12,
            startAngle: 0,
            endAngle: 180,
            clockwise: true
        )
        path.lineWidth = 6
        UIColor.purple.setStroke()
        path.stroke()
        
    }
    
}

private extension ColorPickerView {
        
    func dimmingBackground(for value: CGFloat) {
        
        let context = UIGraphicsGetCurrentContext()
        
        let colors = [
            UIColor(white: 0, alpha: 1 - value).cgColor,
            UIColor(white: 0, alpha: 1 - value).cgColor
        ]
        
        let color = CGGradient(
            colorsSpace: ColorPickerView.colorSpace,
            colors: colors as CFArray,
            locations: nil
        )!
        
        context?.drawLinearGradient(
            color,
            start: CGPoint.zero,
            end: CGPoint(x: 0, y: self.bounds.height),
            options: []
        )
        
    }
    
    static func gradientBackground(for view: UIView, with rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        
        let whiteColorsSet = [
            UIColor(white: 1, alpha: 0).cgColor,
            UIColor(white: 1, alpha: 0.5).cgColor,
            UIColor(white: 1, alpha: 1).cgColor
        ]
        
        let rainbowColorsSet = [
            UIColor.red.cgColor,
            UIColor.orange.cgColor,
            UIColor.yellow.cgColor,
            UIColor.green.cgColor,
            UIColor.cyan.cgColor,
            UIColor.blue.cgColor,
            UIColor.purple.cgColor,
        ]
        
        let whiteGradient = CGGradient(
            colorsSpace: colorSpace,
            colors: whiteColorsSet as CFArray,
            locations: nil
        )!
        
        let rainbowGradient = CGGradient(
            colorsSpace: colorSpace,
            colors: rainbowColorsSet as CFArray,
            locations: nil
        )!
        
        context?.drawLinearGradient(
            rainbowGradient,
            start: CGPoint.zero,
            end: CGPoint(x: view.bounds.width, y: 0),
            options: []
        )
        context?.drawLinearGradient(
            whiteGradient,
            start: CGPoint.zero,
            end: CGPoint(x: 0, y: view.bounds.height),
            options: []
        )
             
    }
    
}

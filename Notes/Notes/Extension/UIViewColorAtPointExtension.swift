//
//  UIViewColorAtPointExtension.swift
//  Notes
//
//  Created by Денис Домашевич on 2/17/20.
//  Copyright © 2020 Денис Домашевич. All rights reserved.
//

import UIKit.UIColor

extension UIView {
    func color(at point: CGPoint) -> UIColor {
        let pixel = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: 4)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        
        let context = CGContext(
            data: pixel,
            width: 1,
            height: 1,
            bitsPerComponent: 8,
            bytesPerRow: 4,
            space: colorSpace,
            bitmapInfo: bitmapInfo.rawValue
        )!

        context.translateBy(x: -point.x, y: -point.y)
        self.layer.render(in: context)
        
        let color = UIColor(
            red:   CGFloat(pixel[0]) / 255.0,
            green: CGFloat(pixel[1]) / 255.0,
            blue:  CGFloat(pixel[2]) / 255.0,
            alpha: CGFloat(pixel[3]) / 255.0
        )

        pixel.deallocate()
        
        return color
    }
}

//
//  ColorPickerViewController.swift
//  Notes
//
//  Created by Денис Домашевич on 2/10/20.
//  Copyright © 2020 Денис Домашевич. All rights reserved.
//

import UIKit

class ColorPickerViewController: UIViewController {
    
    @IBOutlet weak var hexColorLabel: UILabel!
    @IBOutlet weak var brightnessSlider: UISlider!
    
    @IBOutlet weak var colorView: ColorSquareView!
    @IBOutlet weak var gradientPalette: ColorPickerView!
    
    var hasColor: Bool = false
    var brightnessValue: Float = 1.0
    var cursorPositon: CGPoint = .zero
    
    weak var delegate: Colorable?
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        gradientPalette.dimming = sender.value
        updateColorView(for: cursorPositon)
    }
    
    
    @IBAction func pickerTapped(_ sender: UITapGestureRecognizer) {
        cursorPositon = sender.location(in: gradientPalette)
        gradientPalette.cursorPosition = (cursorPositon.x, cursorPositon.y)
        updateColorView(for: cursorPositon)
    }
    
    @IBAction func pickerDragged(_ sender: UIPanGestureRecognizer) {
        cursorPositon = sender.location(in: gradientPalette)
        guard let view = sender.view as? ColorPickerView else { return }
        let translation = sender.translation(in: gradientPalette)
        let point = sender.location(in: gradientPalette)
        if view.point(inside: point, with: nil) {
            let (x, y) = view.cursorPosition
            cursorPositon = CGPoint(
                x: x + translation.x,
                y: y + translation.y
            )
            view.cursorPosition = (cursorPositon.x, cursorPositon.y)
            updateColorView(for: cursorPositon)
            sender.setTranslation(CGPoint.zero, in: gradientPalette)
        }
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if hasColor {
            brightnessSlider.value = brightnessValue
        } else {
            cursorPositon = CGPoint(
                x: gradientPalette.bounds.midX,
                y: gradientPalette.bounds.midY
            )
        }
        
        gradientPalette.dimming = brightnessSlider.value
        gradientPalette.cursorPosition = (cursorPositon.x, cursorPositon.y)
        updateColorView(for: cursorPositon)
    }
    
    func updateColorView(for point: CGPoint) {
        let color = gradientPalette.color(at: point)
        colorView.backgroundColor = color
        hexColorLabel.text = colorView.backgroundColor?.hexValue
        delegate?.passValue(of: color)
        delegate?.passValue(of: cursorPositon, and: brightnessSlider.value)
    }
    
}

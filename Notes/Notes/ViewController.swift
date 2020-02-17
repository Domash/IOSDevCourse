//
//  ViewController.swift
//  Notes
//
//  Created by Денис Домашевич on 1/24/20.
//  Copyright © 2020 Денис Домашевич. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dateSwitch: UISwitch!
    @IBOutlet weak var datePicker: UIDatePicker!

    @IBOutlet var SquareViews: [ColorSquareView]!
    var lastSelectedSquareView: ColorSquareView!
    
    var brightnessValue: Float = 1.0
    var cursorPosition: CGPoint = .zero
    
    @IBAction func dateSwitchValueChanged(_ sender: UISwitch) {
        datePicker.isHidden = !dateSwitch.isOn
    }
    
    @IBAction func changeColor(_ sender: UITapGestureRecognizer) {
        
        guard let view = sender.view as? ColorSquareView else {
            return
        }
        
        if !view.isGradient {
            setColor(view)
        }
        
    }
    
    @IBAction func openColorPicker(_ sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizer.State.began {
            let storyboard = UIStoryboard(name: "ColorPicker", bundle: nil)
            guard let viewController = storyboard.instantiateInitialViewController()
                as? ColorPickerViewController else { return }
            
            viewController.modalPresentationStyle = .overCurrentContext
            viewController.delegate = self
            
            setColor(SquareViews.last)
            
            if !SquareViews.last!.isGradient {
                viewController.hasColor = true
                viewController.cursorPositon = cursorPosition
                viewController.brightnessValue = brightnessValue
            }
            
            present(viewController, animated: true)
        }
    }
    
    private func setColor(_ view: ColorSquareView?) {
        guard let view = view else {
            return
        }
        
        lastSelectedSquareView.isSelected = false
        lastSelectedSquareView.setNeedsDisplay()
        
        view.isSelected = true
        view.setNeedsDisplay()
        
        lastSelectedSquareView = view
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lastSelectedSquareView = SquareViews.first
    }
    
}

extension ViewController: Colorable {
    
    func passValue(of color: UIColor) {
        if lastSelectedSquareView != SquareViews.last {
            lastSelectedSquareView.isSelected = false
            lastSelectedSquareView.setNeedsDisplay()
        }
        lastSelectedSquareView = SquareViews.last
        lastSelectedSquareView.isGradient = false
        lastSelectedSquareView.backgroundColor = color
    }
    
    func passValue(of coordinates: CGPoint, and brightness: Float) {
        cursorPosition = coordinates
        brightnessValue = brightness
    }
}


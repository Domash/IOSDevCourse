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
    
    @IBAction func dateSwitchValueChanged(_ sender: UISwitch) {
        datePicker.isHidden = !dateSwitch.isOn
    }
    
    @IBAction func changeColor(_ sender: UITapGestureRecognizer) {
        setColor(sender.view as? ColorSquareView)
    }
    @IBAction func openColorPicker(_ sender: UILongPressGestureRecognizer) {
        
    }
    
    private func setColor(_ view: ColorSquareView?) {
        guard let view = view else {
            return
        }
        view.isSelected = true
        view.setNeedsDisplay()
        lastSelectedSquareView.isSelected = false
        lastSelectedSquareView.setNeedsDisplay()
        lastSelectedSquareView = view
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        lastSelectedSquareView = SquareViews.first
        
    }
    
}


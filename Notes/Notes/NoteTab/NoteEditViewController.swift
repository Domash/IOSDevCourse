//
//  NoteEditViewController.swift
//  Notes
//
//  Created by Денис Домашевич on 2/23/20.
//  Copyright © 2020 Денис Домашевич. All rights reserved.
//

import UIKit

class NoteEditViewController: UIViewController {

    var notebook: FileNotebook!
    var passedNote: Note? = nil
    
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBOutlet weak var dateSwitch: UISwitch!
    @IBOutlet weak var datePicker: UIDatePicker!

    @IBOutlet var SquareViews: [ColorSquareView]!
    var lastSelectedSquareView: ColorSquareView!
    
    var brightnessValue: Float = 1.0
    var cursorPosition: CGPoint = .zero
    
    @IBOutlet weak var saveBarButton: UIBarButtonItem! {
        didSet {
            saveBarButton.target = self
            saveBarButton.action = #selector(saveBarButtonTapped)
        }
    }
    
    @objc func saveBarButtonTapped() {
        
        guard let title = titleLabel.text else { return  }
        guard let content = contentTextView.text else { return  }
        guard let color = lastSelectedSquareView.backgroundColor else { return  }
        
        var destructionDate: Date? = nil
        if let datePicker = datePicker {
            destructionDate = datePicker.date
        }
        
        if !dateSwitch.isOn {
            destructionDate = nil
        }
        
        if let _ = passedNote {
            guard let uid = passedNote?.uid else { return }
            guard let importance = passedNote?.importance else { return }
            
            let rewriteNote = Note(
                uid: uid,
                title: title,
                content: content,
                color: color,
                importance: importance,
                selfDestructionDate: destructionDate
            )
            //notebook.add(rewriteNote)
            saveNote(rewriteNote)
        } else {
            let newNote = Note(
                title: title,
                content: content,
                color: color,
                selfDestructionDate: destructionDate
            )
            //notebook.add(newNote)
            saveNote(newNote)
        }
        
    }
    
    private func saveNote(_ note: Note) {
        let saveNoteOperation = SaveNoteOperation(
            note: note,
            notebook: notebook,
            backendQueue: OperationQueue(),
            dbQueue: OperationQueue()
        )
        
        saveNoteOperation.completionBlock = {
            OperationQueue.main.addOperation {
                self.passedNote = nil
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        OperationQueue().addOperation(saveNoteOperation)
    }
    
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
    
        SquareViews.last?.backgroundColor = UIColor(
            patternImage: UIImage(named: "gradient_image.jpg")!
        )
        lastSelectedSquareView = SquareViews.first
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setPassedNoteInfo()
    }
    
    private func setPassedNoteInfo() {
        guard let currNote = passedNote else {
            return
        }
    
        titleLabel.text = currNote.title
        contentTextView.text = currNote.content
        
        switch currNote.color {
            case .white:
                setColor(SquareViews[0])
            case .red:
                setColor(SquareViews[1])
            case .systemTeal:
                setColor(SquareViews[2])
            default:
                setColor(SquareViews[3])
                lastSelectedSquareView.isGradient = false
                lastSelectedSquareView.backgroundColor = currNote.color
        }
        
        guard let destructionDate = currNote.selfDestructionDate else {
            return
        }
        
        dateSwitch.isOn = true
        datePicker.isHidden = !dateSwitch.isOn
        datePicker.date = destructionDate
        
    }
    
}

extension NoteEditViewController: Colorable {
    
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



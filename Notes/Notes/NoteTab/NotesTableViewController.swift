//
//  NotesTableViewController.swift
//  Notes
//
//  Created by Денис Домашевич on 2/23/20.
//  Copyright © 2020 Денис Домашевич. All rights reserved.
//

import UIKit

class NotesTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    let notebook = FileNotebook()
    //var note: Note?
    
    @IBOutlet weak var editBarButton: UIBarButtonItem! {
        didSet {
            editBarButton.target = self
            editBarButton.action = #selector(editBarButtonTapped)
        }
    }
    
    @objc func editBarButtonTapped() {
        tableView.isEditing = !tableView.isEditing
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notebook.add(Note(title: "Hello", content: "KEK"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNoteEditVC" {
            guard let noteEditVC = segue.destination as? NoteEditViewController else {
                return
            }
            
            noteEditVC.notebook = notebook
            
            if let indexPathSender = sender as? IndexPath {
                let selectedNote = notebook.notes[indexPathSender.row]
                noteEditVC.passedNote = selectedNote
            }
            
        }
    }
    
}

extension NotesTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notebook.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NoteTableViewCell
        
        let currNote = notebook.notes[indexPath.row]
        
        cell.titleLabel.text = currNote.title
        cell.contentLabel.text = currNote.content
        cell.contentLabel.numberOfLines = 5
        cell.colorView.backgroundColor = currNote.color
        
        return cell
    }
        
}

extension NotesTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        //note = notebook.notes[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showNoteEditVC", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            notebook.remove(with: notebook.notes[indexPath.row].uid)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}

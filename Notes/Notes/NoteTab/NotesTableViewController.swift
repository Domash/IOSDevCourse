//
//  NotesTableViewController.swift
//  Notes
//
//  Created by Денис Домашевич on 2/23/20.
//  Copyright © 2020 Денис Домашевич. All rights reserved.
//

import UIKit

class NotesTableViewController: UIViewController {
    
    let notebook = FileNotebook()
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
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
        
        let loadNotesOperation = LoadNotesOperation(
            notebook: notebook,
            backendQueue: OperationQueue(),
            dbQueue: OperationQueue()
        )
        
        loadNotesOperation.completionBlock = {
            OperationQueue.main.addOperation {
                print(self.notebook.notes.count)
                self.tableView.reloadData()
            }
        }

        OperationQueue().addOperation(loadNotesOperation)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showNoteEditVC", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let noteId = notebook.notes[indexPath.row].uid
            
            let removeNoteOperation = RemoveNoteOperation(
                noteId: noteId,
                notebook: notebook,
                backendQueue: OperationQueue(),
                dbQueue: OperationQueue()
            )
            
            removeNoteOperation.completionBlock = {
                OperationQueue.main.addOperation {
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
            
            OperationQueue().addOperation(removeNoteOperation)
        }
    }
    
}

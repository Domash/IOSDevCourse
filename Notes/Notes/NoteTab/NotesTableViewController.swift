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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notebook.add(Note(title: "Hello", content: "KEK"))
        notebook.add(Note(title: "Gfkld", content: "fjkdjk", color: .cyan, selfDestructionDate: nil))
    }
    
}

extension NotesTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(notebook.notes.count)
        return notebook.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NoteTableViewCell
        
        let currNote = notebook.notes[indexPath.row]
        
        cell.titleLabel.text = currNote.title
        cell.contentLabel.text = currNote.content
        cell.colorView.backgroundColor = currNote.color
        
        return cell
    }
    
}

extension NotesTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        //note = notebook.notes[indexPath.row]
    }
    
}

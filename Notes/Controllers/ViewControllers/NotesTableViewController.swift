//
//  NotesTableViewController.swift
//  Notes
//
//  Created by Steve Lederer on 11/30/18.
//  Copyright © 2018 Steve Lederer. All rights reserved.
//

import UIKit

class NotesTableViewController: UITableViewController {
    
    
    // MARK: - ViewLifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NoteController.shared.notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        let note = NoteController.shared.notes[indexPath.row]
        //Trim out white space and new lines
        let noteTitleTrimmed = note.noteText.trimmingCharacters(in: .whitespacesAndNewlines)
        cell.textLabel?.text = noteTitleTrimmed
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let note = NoteController.shared.notes[indexPath.row]
            NoteController.shared.delete(note: note)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = NoteController.shared.notes[fromIndexPath.row]
        NoteController.shared.notes.remove(at: fromIndexPath.row)
        NoteController.shared.notes.insert(itemToMove, at: destinationIndexPath.row)
        NoteController.shared.saveToPersistentStore()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToNoteDetailView" {
            guard let indexPath = tableView.indexPathForSelectedRow, let destinationVC = segue.destination as? NotesDetailViewController else { return }
            let note = NoteController.shared.notes[indexPath.row]
            destinationVC.note = note
        }
    }
}

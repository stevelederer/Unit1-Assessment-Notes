//
//  NotesDetailViewController.swift
//  Notes
//
//  Created by Steve Lederer on 11/30/18.
//  Copyright © 2018 Steve Lederer. All rights reserved.
//

import UIKit

class NotesDetailViewController: UIViewController {
    
    var note: Note?
    
    // MARK: - Outlets
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var textViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: - ViewLifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    // MARK: - Actions
    @IBAction func saveNoteButtonTapped(_ sender: Any) {
        guard let noteText = noteTextView.text else { return }
        if noteText != "" {
            if let note = note {
                NoteController.shared.update(note: note, newText: noteText)
            } else {
                NoteController.shared.create(note: noteText)
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    func updateView() {
        if let note = note {
            noteTextView?.text = note.noteText
            self.title = "Edit Note"
        } else {
            noteTextView.clearsOnInsertion = true
            self.title = "New Note"
        }
    }
}

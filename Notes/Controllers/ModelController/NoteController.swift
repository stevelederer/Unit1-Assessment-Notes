//
//  NoteController.swift
//  Notes
//
//  Created by Steve Lederer on 11/30/18.
//  Copyright © 2018 Steve Lederer. All rights reserved.
//

import Foundation

class NoteController {
    
    // MARK: - Shared Instance
    static let shared = NoteController()
    
    // MARK: - Source of Truth
    var notes: [Note] = []
    
    init() {
        loadFromPersistentStore()
    }
    
    // MARK: - CRUD Functions
    func create(note withNoteText: String) {
        let newNote = Note(note: withNoteText)
        self.notes.append(newNote)
        saveToPersistentStore()
    }
    
    func update(note: Note, newText: String) {
        note.noteText = newText
        saveToPersistentStore()
    }
    
    func delete(note: Note) {
        if let index = self.notes.index(of: note) {
            notes.remove(at: index)
        }
        saveToPersistentStore()
    }
    
    func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        let fileName = "notes.json"
        let fullURL = documentDirectory.appendingPathComponent(fileName)
        return fullURL
    }
    func saveToPersistentStore() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self.notes)
            try data.write(to: fileURL())
        } catch let e {
            print("There was an error saving to persistent storage: \(e.localizedDescription)")
        }
    }
    
    func loadFromPersistentStore() {
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL())
            let notes = try decoder.decode([Note].self, from: data)
            self.notes = notes
        } catch let e {
            print("There was an error loading from persistent storage: \(e.localizedDescription)")
        }
    }
}

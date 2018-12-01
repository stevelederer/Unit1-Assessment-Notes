//
//  Note.swift
//  Notes
//
//  Created by Steve Lederer on 11/30/18.
//  Copyright © 2018 Steve Lederer. All rights reserved.
//

import Foundation

class Note: Equatable, Codable {
    
    // MARK: - Properties
    var noteText: String
    
    // MARK: - Initialization
    init(note: String) {
        self.noteText = note
    }
    
    // MARK: - Equatable
    static func == (lhs: Note, rhs: Note) -> Bool {
        return lhs.noteText == rhs.noteText
    }
    
}

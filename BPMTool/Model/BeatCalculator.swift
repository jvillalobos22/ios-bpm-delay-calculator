//
//  BeatCalculator.swift
//  BPMTool
//
//  Created by Juan Villalobos on 11/16/19.
//  Copyright © 2019 Juanton. All rights reserved.
//

import Foundation

let notesDictionary: [String:Double] = [
    "Whole Beat": 1.0,
    "Half Beat": 0.5,
    "1/4 Beat": 0.25,
    "1/8 Beat": 0.125,
    "1/16 Beat": 0.0625,
    "1/32 Beat": 0.03125,
    "1/64 Beat": 0.015625
]

enum ListType {
   case base
   case dotted
   case triplet
   case all
}

class BeatCalculator {

    var bpmValue: Double?
    
    var lengthsToShow: ListType = .base {
        didSet {
            updateNoteLengths()
        }
    }
    
    var noteLengths = [NoteLength]()
    
    init(withStartingBpm bpm: Double) {
        bpmValue = bpm
        for (noteString, noteCoefficient) in notesDictionary {
            let newNoteLength = NoteLength(noteCoefficient: noteCoefficient, noteString: noteString, noteType: .base);
            noteLengths.append(newNoteLength)
        }
    }
    
    func getSortedNoteLengths() -> [NoteLength] {
//        let sortedNoteLengths = noteLengths.sorted(by: { $0.noteCoefficient > $1.noteCoefficient })
        let sortedNoteLengths = noteLengths.sorted()
        return sortedNoteLengths
    }
    
    func updateNoteLengths() -> Void {
        var newArray = [NoteLength]()

        switch lengthsToShow {
        case .base:
            for (noteString, noteCoefficient) in notesDictionary {
                let newNoteLength = NoteLength(noteCoefficient: noteCoefficient, noteString: noteString, noteType: .base);
                newArray.append(newNoteLength)
            }
        case .dotted:
            for (noteString, noteCoefficient) in notesDictionary {
                if (noteCoefficient != 1.0) {
                    let newNoteLength = NoteLength(noteCoefficient: noteCoefficient, noteString: noteString, noteType: .dotted);
                    newArray.append(newNoteLength)
                }
            }
        case .triplet:
            for (noteString, noteCoefficient) in notesDictionary {
                if (noteCoefficient != 1.0) {
                    let newNoteLength = NoteLength(noteCoefficient: noteCoefficient, noteString: noteString, noteType: .triplet);
                    newArray.append(newNoteLength)
                }
            }
        case .all:
            for (noteString, noteCoefficient) in notesDictionary {
                let newNoteLength = NoteLength(noteCoefficient: noteCoefficient, noteString: noteString, noteType: .base);
                let newDottedNoteLength = NoteLength(noteCoefficient: noteCoefficient, noteString: noteString, noteType: .dotted);
                let newTripletNoteLength = NoteLength(noteCoefficient: noteCoefficient, noteString: noteString, noteType: .triplet);
                newArray.append(newNoteLength)
                if (noteCoefficient != 1.0) {
                    newArray.append(newDottedNoteLength)
                    newArray.append(newTripletNoteLength)
                }
            }
        }
        noteLengths = newArray
    }
}

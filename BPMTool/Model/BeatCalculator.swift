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

class BeatCalculator {
    var bpmValue: Double?
    
    var noteLengths = [NoteLength]()
    
    init(withStartingBpm bpm: Double) {
        bpmValue = bpm
        for (noteString, noteCoefficient) in notesDictionary {
            let newNoteLength = NoteLength(noteCoefficient: noteCoefficient, noteString: noteString);
            noteLengths.append(newNoteLength)
        }
    }
}

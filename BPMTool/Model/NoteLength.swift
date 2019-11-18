//
//  NoteLength.swift
//  BPMTool
//
//  Created by Juan Villalobos on 11/16/19.
//  Copyright © 2019 Juanton. All rights reserved.
//

import Foundation

enum NoteType {
   case base
   case dotted
   case triplet
}

var noteTypeToNumerator: [NoteType:Double] = [
    .base: 240_000,
    .dotted: 360_000,
    .triplet: 160_000
]

struct NoteLength: Comparable {
    var noteCoefficient: Double
    var noteString: String
    var noteType: NoteType = .base
    
    func getNoteLength(forBpm bpm: Double?) -> Measurement<UnitDuration> {
        if let bpm = bpm {
            let numerator = noteTypeToNumerator[noteType]!
            let timeInMs = (numerator / bpm) * noteCoefficient;
            return Measurement(value: timeInMs, unit: UnitDuration.milliseconds)
        } else {
            return Measurement(value: 0.00, unit: UnitDuration.milliseconds)
        }
    }
    
    static func <(lhs: NoteLength, rhs: NoteLength) -> Bool {
        if (lhs.noteCoefficient != rhs.noteCoefficient) {
            return lhs.noteCoefficient > rhs.noteCoefficient
        }
        
        switch (lhs.noteType, rhs.noteType) {
        case (.base, .triplet):
            return true
        case (.dotted, .base):
            return true
        case (.dotted, .triplet):
            return true
        case (.base, .base):
            return false
        case (.dotted, .dotted):
            return false
        case (.triplet, .triplet):
            return false
        default:
            return false
        }
    }
}

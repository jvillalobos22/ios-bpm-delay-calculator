//
//  NoteLengths.swift
//  BPMTool
//
//  Created by Juan Villalobos on 11/16/19.
//  Copyright © 2019 Juanton. All rights reserved.
//

import Foundation

struct NoteLength {
    var noteCoefficient: Double
    var noteString: String
    
    func getNoteLength(forBpm bpm: Double) -> Measurement<UnitDuration> {
        let timeInMs = (240_000 / bpm) * noteCoefficient;
        return Measurement(value: timeInMs, unit: UnitDuration.milliseconds)
    }
}

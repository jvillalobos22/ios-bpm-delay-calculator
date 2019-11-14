//
//  ViewController.swift
//  BPMTool
//
//  Created by Juan Villalobos on 11/11/19.
//  Copyright © 2019 Juanton. All rights reserved.
//

import UIKit

let numberFormatter: NumberFormatter = {
    let nf = NumberFormatter()
    nf.numberStyle = .decimal
    nf.minimumFractionDigits = 0
    nf.maximumFractionDigits = 2
    return nf
}()

//let NoteLength = [
//    "bar": 1,
//    "half": 0.5,
//    "quarter": 0.25,
//    "eighth": 0.125,
//    "sixteenth": 0.0625,
//    "thirtysecondth": 0.03125,
//    "sixtyfourth": 0.015625
//]

let noteLengths = [
    1.0,
    0.5,
    0.25,
    0.125,
    0.0625,
    0.03125,
    0.015625
]

let noteStrings = [
    "Whole Beat",
    "Half Beat",
    "1/4 Beat",
    "1/8 Beat",
    "1/16 Beat",
    "1/32 Beat",
    "1/64 Beat"
]

struct Length {}

class ViewController: UIViewController,  UITextFieldDelegate {

    @IBOutlet var noteLengthLabels: [UILabel]!
    
//    @IBOutlet var quarterNoteLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    var bpmValue: Double? {
        didSet {
            updateNoteValueLabels(for: noteLengthLabels)
        }
    }
    
    func updateNoteValueLabels(for labels: Array<UILabel?>) {
        for i in labels.indices {
            let calculatedNoteLength = calculateNoteValue(forNoteLength: noteLengths[i])
            let formattedNoteLength = numberFormatter.string(from: NSNumber(value: calculatedNoteLength.value))
            
            if let label = labels[i] {
                label.text = "\(noteStrings[i]): \(formattedNoteLength!)ms"
            } else {
                print("error updating labels")
            }
        }
    }
    
    func calculateNoteValue(forNoteLength noteLength: Double) -> Measurement<UnitDuration> {
        if let bpmValue = bpmValue {
            let timeInMs = (240_000 / bpmValue) * noteLength;
            return Measurement(value: timeInMs, unit: UnitDuration.milliseconds)
        } else {
            return Measurement(value: 0.00, unit: UnitDuration.milliseconds)
        }
    }
    
    override func viewDidLoad() {
         super.viewDidLoad()
        
         print("ViewController loaded its view")
     }
    
     @IBAction func bpmFieldChanged(_ textField: UITextField) {
        if let text = textField.text, let value = Double(text) {
            bpmValue = value
        } else {
            bpmValue = nil
        }
     }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }

 
}


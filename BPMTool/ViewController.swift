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

class ViewController: UIViewController,  UITextFieldDelegate {

    @IBOutlet var noteLengthLabels: [UILabel]!
    
    @IBOutlet var textField: UITextField!
        
    var calculator = BeatCalculator(withStartingBpm: 124.0)
    
    func updateNoteValueLabels(for labels: Array<UILabel?>) {
        let sortedNoteLengths = calculator.noteLengths.sorted(by: { $0.noteCoefficient > $1.noteCoefficient })
        for i in labels.indices {
            let calculatedNoteLength = sortedNoteLengths[i].getNoteLength(forBpm: calculator.bpmValue)
            
            let formattedNoteLength = numberFormatter.string(from: NSNumber(value: calculatedNoteLength.value))
            
            if let label = labels[i] {
                label.text = "\(sortedNoteLengths[i].noteString): \(formattedNoteLength!)ms"
            } else {
                print("error updating labels")
            }
        }
    }
    
    func setBpmValueAndRecalculate(with bpm: Double?) {
        calculator.bpmValue = bpm
        updateNoteValueLabels(for: noteLengthLabels)
    }
    
    override func viewDidLoad() {
         super.viewDidLoad()
        
        textField.text = String(124)
        updateNoteValueLabels(for: noteLengthLabels)
     }
    
     @IBAction func bpmFieldChanged(_ textField: UITextField) {
        if let text = textField.text, let value = Double(text) {
            setBpmValueAndRecalculate(with: value)
        } else {
            setBpmValueAndRecalculate(with: nil)
        }
     }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }

 
}


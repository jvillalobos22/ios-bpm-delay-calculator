//
//  BeatCalculatorViewController.swift
//  BPMTool
//
//  Created by Juan Villalobos on 11/16/19.
//  Copyright © 2019 Juanton. All rights reserved.
//

import UIKit

class BeatCalculatorViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var textField: UITextField!
        
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var calculator = BeatCalculator(withStartingBpm: 124.0)
    
    let CellIdentifier = "com.juanton.NoteMeasurementCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = String(124)
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath) as! NoteMeasurementCell
        
        let sortedNoteLengths = calculator.getSortedNoteLengths();
        
        let calculatedNoteLength = sortedNoteLengths[indexPath.row].getNoteLength(forBpm: calculator.bpmValue)
        
        let formattedNoteLength = numberFormatter.string(from: NSNumber(value: calculatedNoteLength.value))
        
        var noteLengthText = sortedNoteLengths[indexPath.row].noteString
        
        if (sortedNoteLengths[indexPath.row].noteType == .dotted) {
            noteLengthText.append(" dotted")
        } else if (sortedNoteLengths[indexPath.row].noteType == .triplet) {
            noteLengthText.append(" triplet")
        }
            
        cell.noteLengthLabel?.text = noteLengthText
        cell.noteMeasurementLabel?.text = "\(formattedNoteLength!)ms"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calculator.noteLengths.count
    }
    
    func setBpmValueAndRecalculate(with bpm: Double?) {
        calculator.bpmValue = bpm
        
        tableView.reloadData()
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
    
    @IBAction func listTypeChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            calculator.lengthsToShow = .base
        case 1:
            calculator.lengthsToShow = .dotted
        case 2:
            calculator.lengthsToShow = .triplet
        case 3:
            calculator.lengthsToShow = .all
        default:
            break
        }
        
        tableView.reloadData()
    }
}

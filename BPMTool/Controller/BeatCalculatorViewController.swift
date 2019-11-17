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
        
    var calculator = BeatCalculator(withStartingBpm: 124.0)
    
    let CellIdentifier = "com.juanton.NoteMeasurementCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = String(124)
        tableView.dataSource = self
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath) as! NoteMeasurementCell
        
        let sortedNoteLengths = calculator.getSortedNoteLengths();
        
        let calculatedNoteLength = sortedNoteLengths[indexPath.row].getNoteLength(forBpm: calculator.bpmValue)
        
        let formattedNoteLength = numberFormatter.string(from: NSNumber(value: calculatedNoteLength.value))
        
//        cell.textLabel?.text = "\(sortedNoteLengths[indexPath.row].noteString): \(formattedNoteLength!)ms"
        
        cell.noteLengthLabel?.text = sortedNoteLengths[indexPath.row].noteString
        cell.noteMeasurementLabel?.text = "\(formattedNoteLength!)ms"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calculator.noteLengths.count
    }
    
    func setBpmValueAndRecalculate(with bpm: Double?) {
        calculator.bpmValue = bpm
        print("should call tableView.reloadData()")
        tableView.reloadData()
    }
    
    @IBAction func bpmFieldChanged(_ textField: UITextField) {
        print("should call bpmFieldChanged(_:)")
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

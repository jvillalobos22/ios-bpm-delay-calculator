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
    
    let CellIdentifier = "BeatCalculationCell"
    
    let data = ["New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX",
        "Philadelphia, PA", "Phoenix, AZ", "San Diego, CA", "San Antonio, TX",
        "Dallas, TX", "Detroit, MI", "San Jose, CA", "Indianapolis, IN",
        "Jacksonville, FL", "San Francisco, CA", "Columbus, OH", "Austin, TX",
        "Memphis, TN", "Baltimore, MD", "Charlotte, ND", "Fort Worth, TX"]

    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = String(124)
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CellIdentifier)
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath)
        
        print("indexPath.row", indexPath.row)
        let sortedNoteLengths = calculator.getSortedNoteLengths();
        
        let calculatedNoteLength = sortedNoteLengths[indexPath.row].getNoteLength(forBpm: calculator.bpmValue)
        
        let formattedNoteLength = numberFormatter.string(from: NSNumber(value: calculatedNoteLength.value))
        
        cell.textLabel?.text = "\(sortedNoteLengths[indexPath.row].noteString): \(formattedNoteLength!)ms"
        
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

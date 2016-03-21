//
//  NumberPadController.swift
//  control
//
//  Created by Mariana Medeiro on 18/03/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import WatchKit
import Foundation


class NumberPadController: WKInterfaceController {
    
    @IBOutlet var amountLabel: WKInterfaceLabel!
    var isDecimalAppended = false
    var isPointZeroAppended = false
    var sourceController: DefinirLimiteController!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func appendValue(value: Int){
        let newValue = "\(value)"
        var currentValue = getDisplayAmount(sourceController.amount, round: false)
        
        if currentValue == "0" && !isDecimalAppended {
            currentValue = newValue
        } else  {
            if isPointZeroAppended{
                currentValue += currentValue.rangeOfString(".") != nil
                    ? "0" : ".0"
                isPointZeroAppended = false
                
            }
            
            if isDecimalAppended {
                currentValue += "."
                isDecimalAppended = false
            }
            
            if value == 0 && currentValue.rangeOfString(".") != nil {
                isPointZeroAppended = true
            }
            
            currentValue += newValue
        }
        
        amountLabel.setText(currentValue)
        
    }
    
    func getDisplayAmount(value: Double, round: Bool = true) -> String{
        return value % 1 == 0
        ? "\(Int(value))"
        : (round ? String(format: "%.2f", value): "\(value)")
    }
    
    @IBAction func zeroTapped() {
        appendValue(0)
    }
    @IBAction func oneTapped() {
        appendValue(1)
    }
    @IBAction func twoTapped() {
        appendValue(2)
    }
    @IBAction func threeTapped() {
        appendValue(3)
    }
    @IBAction func fourTapped() {
        appendValue(4)
    }
    @IBAction func fiveTapped() {
        appendValue(5)
    }
    @IBAction func sixTapped() {
        appendValue(6)
    }
    @IBAction func sevenTapped() {
        appendValue(7)
    }
    @IBAction func eightTapped() {
        appendValue(8)
    }
    @IBAction func nineTapped() {
        appendValue(9)
    }
    @IBAction func clearTapped() {
        amountLabel.setText("0")
        isDecimalAppended = false
    }
    @IBAction func pointTapped() {
        var currentValue = getDisplayAmount(sourceController.amount)
        
        if currentValue.rangeOfString(".") == nil {
            currentValue += "."
            amountLabel.setText(currentValue)
            isDecimalAppended = true
        }
    }
    @IBAction func doneTapped() {
    }

}

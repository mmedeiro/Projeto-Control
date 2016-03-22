//
//  DefinirLimiteController.swift
//  control
//
//  Created by Mariana Medeiro on 18/03/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import WatchKit
import Foundation


class DefinirLimiteController: WKInterfaceController {
    
    var amount = Double(0)

    @IBOutlet var limiteDefinido: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        loadData()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func loadData() {
        limiteDefinido.setText(getDisplayAmount(amount))
    }
    
    @IBAction func dictationAction() {
        presentTextInputControllerWithSuggestions(["R$2,75","R$50,00", "R$100,00"], allowedInputMode: .Plain) { (results) -> Void in
            
            self.limiteDefinido.setText(results?.first as? String)
        }
    }

    @IBAction func textationAction() {
        self.presentControllerWithName("numericKeyboard", context: self)
        
        
    }
    
    func getDisplayAmount(value: Double, round: Bool = true) -> String {
        // Truncate decimal if whole number
        return value % 1 == 0
            ? "\(Int(value))"
            : (round ? String(format: "%.2f", value) : "\(value)")
    }
}

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
    var valorGasto : Double!
    @IBOutlet var limiteDefinido: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        if context != nil{
            valorGasto = context as! Double
        } else {
            valorGasto = 0
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        if amount != 0{
        let array = [amount, valorGasto]
        DefinirLimiteController.reloadRootControllersWithNames(["idtxt"], contexts: [array])
        }
        
        loadData()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func loadData() {
       limiteDefinido.setText(getDisplayAmount(amount))
    }
    

    @IBAction func textationAction() {
        let array = [self, "DefinirLimiteController"]
        self.presentControllerWithName("numericKeyboard", context: "inicio")
    }
    
    func getDisplayAmount(value: Double, round: Bool = true) -> String {
        // Truncate decimal if whole number
        return value % 1 == 0
            ? "\(Int(value))"
            : (round ? String(format: "%.2f", value) : "\(value)")
    }
}

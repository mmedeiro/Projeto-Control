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
    var limiteSC: DefinirLimiteController!
    var ilimitadoSC: PrecoIlimitadoController!
    var limitadoSC: PrecoLimitadoInterfaceController!
    var nomeDaClasse: String!
    var valor: String!
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)

        if context![1] as! String == "DefinirLimiteController"{
            limiteSC = context![0] as! DefinirLimiteController
            amountLabel.setText("\(limiteSC.getDisplayAmount(limiteSC.amount))")
            nomeDaClasse = "limite"
        } else if context![1] as! String == "PrecoIlimitadoController"{
           ilimitadoSC = context![0] as! PrecoIlimitadoController
            amountLabel.setText("\(ilimitadoSC.getDisplayAmount(ilimitadoSC.amount))")
            nomeDaClasse = "ilimitado"
        } else if context![1] as! String == "PrecoLimitadoInterfaceController"{
            limitadoSC = context![0] as! PrecoLimitadoInterfaceController
            amountLabel.setText("\(limitadoSC.getDisplayAmount(limitadoSC.amount))")
            nomeDaClasse = "limitado"
        }
        
        if nomeDaClasse == "limite"{
            limiteSC.amount = 0.0
        } else if nomeDaClasse == "ilimitado"{
            ilimitadoSC.amount = 0.0
        } else if nomeDaClasse == "limitado" {
            limitadoSC.amount = 0.0
        }
        
        amountLabel.setText("0.0")
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
        var currentValue = String()
        
        if nomeDaClasse == "limite"{
         currentValue = limiteSC.getDisplayAmount(limiteSC.amount, round: false)
        } else if nomeDaClasse == "ilimitado"{
        currentValue = ilimitadoSC.getDisplayAmount(ilimitadoSC.amount, round: false)
        } else if nomeDaClasse == "limitado"{
        currentValue = limitadoSC.getDisplayAmount(limitadoSC.amount, round: false)
        }
        
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
        
        if nomeDaClasse == "limite"{
            limiteSC.amount = (currentValue as NSString).doubleValue
        } else if nomeDaClasse == "ilimitado"{
            ilimitadoSC.amount = (currentValue as NSString).doubleValue
        } else if nomeDaClasse == "limitado"{
            limitadoSC.amount = (currentValue as NSString).doubleValue
        }
        
        amountLabel.setText(currentValue)
        valor = currentValue
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
        if nomeDaClasse == "limite"{
            limiteSC.amount = 0.0
        } else if nomeDaClasse == "ilimitado"{
            ilimitadoSC.amount = 0.0
        } else if nomeDaClasse == "limitado"{
            limitadoSC.amount = 0.0
        }
        amountLabel.setText("0")
        isDecimalAppended = false
    }
    
    @IBAction func pointTapped() {
        var currentValue =  String()
        var valor = String()
        
        if nomeDaClasse == "limite"{
            valor = limiteSC.getDisplayAmount(limiteSC.amount)
        } else if nomeDaClasse == "ilimitado"{
            valor =  ilimitadoSC.getDisplayAmount(ilimitadoSC.amount)
        } else if nomeDaClasse == "limitado"{
            valor = limitadoSC.getDisplayAmount(limitadoSC.amount)
        }
        
        if currentValue.rangeOfString(".") == nil {
            currentValue = valor + "."
            amountLabel.setText(currentValue)
            isDecimalAppended = true
        }
    }
    
    @IBAction func doneTapped() {
        if nomeDaClasse == "limite"{
            self.presentControllerWithName("idtxt", context: limiteSC.getDisplayAmount(limiteSC.amount))
        }
    }
}

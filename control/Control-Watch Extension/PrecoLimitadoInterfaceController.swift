//
//  PrecoLimitadoInterfaceController.swift
//  control
//
//  Created by Amanda Campos on 22/03/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import WatchKit
import Foundation


class PrecoLimitadoInterfaceController: WKInterfaceController {

//    let udValor = NSUserDefaults.standardUserDefaults()
    
    var valor: Double!
    var total = Double(0)
    var amount = Double(0)
    var msg = String()
    var controler = true
    
    @IBOutlet var limite: WKInterfaceLabel!
    @IBOutlet var quantiaGasta: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
//        PrecoLimitadoInterfaceController.reloadRootControllersWithNames(["limitado"], contexts: nil)

        
        addMenuItemWithItemIcon(.Accept, title: "Salvar", action: #selector(PrecoLimitadoInterfaceController.salvar))
        addMenuItemWithItemIcon(.Resume, title: "Alterar Limite", action: #selector(PrecoLimitadoInterfaceController.alterarLimite))
        valor = context as! Double
        msg = ""
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        //salvar
        if controler == true{
            total = amount + total
            valor = valor - total
            controler = false
        }
        loadData()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        if msg == "calculadora" || msg == "voz"{
            controler = true
        } else {
            controler = false
        }
        msg = ""
    }

    func loadData() {
        limite.setText("Limite: \(valor)")
        quantiaGasta.setText("\(getDisplayAmount(total))")
    }
    
//    @IBAction func dictationAction() {
//        presentTextInputControllerWithSuggestions(["R$2,75","R$50,00", "R$100,00"], allowedInputMode: .Plain) { (results) -> Void in
//            self.msg = "voz"
//            self.quantiaGasta.setText(results?.first as? String)
//        }
//    }
    
    @IBAction func textationAction() {
        msg = "calculadora"
        let array = [self, "PrecoLimitadoInterfaceController"]
        self.presentControllerWithName("numericKeyboard", context: array)
        
    }
    
    func getDisplayAmount(value: Double, round: Bool = true) -> String {
        // Truncate decimal if whole number
        return value % 1 == 0
            ? "\(Int(value))"
            : (round ? String(format: "%.2f", value) : "\(value)")
    }
    
     func salvar(){
        //salvar...
//        udValor.setValue(total, forKeyPath: "totalLista")
//        udValor.synchronize()
        
        let array = [self,"PrecoLimitadoController"]
        self.presentControllerWithName("nomearLista", context: array)
    }
    
     func alterarLimite(){
        self.presentControllerWithName("DefinirLimiteController", context: nil)
    }
    
}

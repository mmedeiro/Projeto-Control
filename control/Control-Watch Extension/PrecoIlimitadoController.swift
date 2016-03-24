//
//  PrecoFixoController.swift
//  control
//
//  Created by Mariana Medeiro on 18/03/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import WatchKit
import Foundation


class PrecoIlimitadoController: WKInterfaceController {

//    let udValor = NSUserDefaults.standardUserDefaults()
    
    var amount = Double(0)
    var total = Double(0)
    var controler = true
    var msg = String()
    
    @IBOutlet var limiteDefinido: WKInterfaceLabel!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
//        PrecoIlimitadoController.reloadRootControllersWithNames(["ilimitado"], contexts: nil)

        addMenuItemWithItemIcon(.Accept, title: "Salvar", action: "salvar")
        msg = ""
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        //salvar
        if controler == true{
            total = amount + total
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
        limiteDefinido.setText(getDisplayAmount(total))
    }
    
//    @IBAction func dictationAction() {
//        presentTextInputControllerWithSuggestions(["R$2,75","R$50,00", "R$100,00"], allowedInputMode: .Plain) { (results) -> Void in
//            self.msg = "voz"
//            var preco = String()
//            preco = (results?.first as? String)!
//            preco.stringByReplacingOccurrencesOfString("R$", withString: "")
//            print(preco)
//            self.amount = Double(preco)!
//        }
//    }
    
    @IBAction func textationAction() {
        msg = "calculadora"
        let array = [self, "PrecoIlimitadoController"]
//        PrecoIlimitadoController.reloadRootControllersWithNames(["numericKeyboard"], contexts: [array])
        self.presentControllerWithName("numericKeyboard", context: array)
    }
    
    func getDisplayAmount(value: Double, round: Bool = true) -> String {
        // Truncate decimal if whole number
        return value % 1 == 0
            ? "\(Int(value))"
            : (round ? String(format: "%.2f", value) : "\(value)")
    }
    
    func salvar(){
        //salvar nsuserdefault...
//        udValor.setValue(total, forKeyPath: "totalLista")
//        udValor.synchronize()
        
        self.presentControllerWithName("nomearLista", context: nil)
    }
}

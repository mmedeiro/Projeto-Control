//
//  PrecoLimitadoInterfaceController.swift
//  control
//
//  Created by Amanda Campos on 22/03/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class PrecoLimitadoInterfaceController: WKInterfaceController, WCSessionDelegate {
    
    var valor: Double!
    var valorAlterado: Double!
    var total = Double(0)
    var amount = Double(0)
    var msg = String()
    var controler = true
    
    @IBOutlet var limite: WKInterfaceLabel!
    @IBOutlet var quantiaGasta: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)

        if WCSession.isSupported(){
            WCSession.defaultSession().delegate = self
            WCSession.defaultSession().activateSession()
            print(#function, "Ativado")
        } else {
            print(#function, "Desativado")
        }
        
        addMenuItemWithItemIcon(.Accept, title: "Salvar", action: #selector(PrecoLimitadoInterfaceController.salvar))
        addMenuItemWithItemIcon(.Resume, title: "Alterar Limite", action: #selector(PrecoLimitadoInterfaceController.alterarLimite))
        valor = context![0] as! Double
        total = context![1] as! Double

        msg = ""
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()

        if controler == true{
            total = amount + total
            valorAlterado = valor - total
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
        limite.setText("Limite: \(valorAlterado)")
        quantiaGasta.setText("\(getDisplayAmount(total))")
    }
    
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
        //envia msg para iPhone
        var dict:[String:Double] = [String:Double]()
        
        dict["totalProdutos"] = total
        dict["limiteLista"] = valor
        
        WCSession.defaultSession().sendMessage(dict, replyHandler: { (message) -> Void in
            print(#function, "Mensagem enviada")
        }) { (error) -> Void in
            print(#function, "Erro ao enviar mensagem: \(error)")
        }
        
        let array = [self,"PrecoLimitadoController"]
        self.presentControllerWithName("nomearLista", context: array)
    }
    
     func alterarLimite(){
        self.presentControllerWithName("limitado", context: total)
    }
}

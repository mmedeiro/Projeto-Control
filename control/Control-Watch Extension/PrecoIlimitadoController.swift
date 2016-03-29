//
//  PrecoFixoController.swift
//  control
//
//  Created by Mariana Medeiro on 18/03/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class PrecoIlimitadoController: WKInterfaceController , WCSessionDelegate {
    
    var amount = Double(0)
    var total = Double(0)
    var controler = true
    var msg = String()
    
    @IBOutlet var limiteDefinido: WKInterfaceLabel!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        if WCSession.isSupported(){
            WCSession.defaultSession().delegate = self
            WCSession.defaultSession().activateSession()
            print(#function, "Ativado")
        } else {
            print(#function, "Desativado")
        }

        addMenuItemWithItemIcon(.Accept, title: "Salvar", action: #selector(PrecoIlimitadoController.salvar))
        msg = ""
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        if controler == true{
            total = amount + total
            controler = false
        }
        loadData()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        if msg == "calculadora" {
            controler = true
        } else {
            controler = false
        }
        msg = ""
    }
    
    func loadData() {
        limiteDefinido.setText(getDisplayAmount(total))
    }
    
    @IBAction func textationAction() {
        msg = "calculadora"
        let array = [self, "PrecoIlimitadoController"]
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
        var dict: [String:Double] = [String:Double]()
        
        dict["totalProdutos"] = total
        dict["limiteLista"] = 0
        
        WCSession.defaultSession().sendMessage(dict, replyHandler: { (message) in
            print(#function, "Mensagem enviada")
            }) { (error) in
                print(#function, "Erro ao enviar mensagem: \(error)")
        }
        
        let array = [self,"PrecoIlimitadoController"]
        self.presentControllerWithName("nomearLista", context: array)
    }
}

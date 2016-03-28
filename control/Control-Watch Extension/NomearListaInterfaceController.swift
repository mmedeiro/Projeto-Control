//
//  NomearListaInterfaceController.swift
//  control
//
//  Created by Amanda Campos on 23/03/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class NomearListaInterfaceController: WKInterfaceController, WCSessionDelegate {

//    let ud = NSUserDefaults.standardUserDefaults()
    var ilimitadoSC : PrecoIlimitadoController!
    var limitadoSC: PrecoLimitadoInterfaceController!
    var totalLista : String!
    var nomeDaClasse: String!
    var nome = String()
    
    @IBOutlet var nomeDaLista: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        if context![1] as! String == "PrecoIlimitadoController"{
            ilimitadoSC = context![0] as! PrecoIlimitadoController
            totalLista = ilimitadoSC.getDisplayAmount(ilimitadoSC.total)
//            nomeDaClasse = "ilimitado"
        } else if context![1] as! String == "PrecoLimitadoController"{
            limitadoSC = context![0] as! PrecoLimitadoInterfaceController
            totalLista = limitadoSC.getDisplayAmount(limitadoSC.total)
//            nomeDaClasse = "limitado"
        }
        
            addMenuItemWithItemIcon(.Accept, title: "Salvar", action: #selector(NomearListaInterfaceController.salvar))
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func getDisplayAmount(total: Double) -> Double{
        return total
    }
    
    func salvar(){
        //salvar...
        var dict:[String:String] = [String:String]()
        
        dict["nomeLista"] = nome
        dict["total"] = totalLista
        
        print(dict)
        if WCSession.defaultSession().reachable == true {
            
            WCSession.defaultSession().sendMessage(dict, replyHandler: { (message) -> Void in
                print(#function, "Mensagem enviada")
            }) { (error) -> Void in
                print(#function, "Erro ao enviar mensagem: \(error)")
            }
        }
        let ok = WKAlertAction(title: "ok", style: .Default) { () -> Void in
            WKInterfaceController.reloadRootControllersWithNames(["home"], contexts: nil)
        }
        
        presentAlertControllerWithTitle("Salvo", message: "Sua lista foi salva, veja mais detalhe no seu iPhone", preferredStyle: .Alert, actions: [ok])
    }

    @IBAction func reconhecimentoDeVoz() {
        presentTextInputControllerWithSuggestions(["Mercado", "Restaurante", "Balada", "Bar"], allowedInputMode: .Plain) { (resultados) -> Void in
            self.nomeDaLista.setText(resultados?.first as? String)
            print(self.nomeDaLista)
            self.nome = (resultados?.first as? String)!
        }
    }
}

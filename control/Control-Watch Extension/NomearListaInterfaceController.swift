//
//  NomearListaInterfaceController.swift
//  control
//
//  Created by Amanda Campos on 23/03/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import WatchKit
import Foundation


class NomearListaInterfaceController: WKInterfaceController {

//    let ud = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet var nomeDaLista: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        addMenuItemWithItemIcon(.Accept, title: "Salvar", action: "salvar")
        // Configure interface objects here.
        print("outra tela")
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func salvar(){
        //salvar...
        let ok = WKAlertAction(title: "ok", style: .Default) { () -> Void in
            WKInterfaceController.reloadRootControllersWithNames(["home"], contexts: nil)
        }
        //como pegar O NOME REAL? 
//        ud.setValue(nomeDaLista, forKeyPath: "nomeLista")
//        ud.synchronize()
        
        presentAlertControllerWithTitle("Salvo", message: "Sua lista foi salva, veja mais detalhe no seu Iphone", preferredStyle: .Alert, actions: [ok])
    }

    @IBAction func reconhecimentoDeVoz() {
        presentTextInputControllerWithSuggestions(["Mercado", "Restaurante", "Balada", "Bar"], allowedInputMode: .Plain) { (resultados) -> Void in
            self.nomeDaLista.setText(resultados?.first as? String)
        }
    }
}

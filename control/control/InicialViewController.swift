//
//  InicialViewController.swift
//  control
//
//  Created by Amanda Campos on 15/06/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit
import WatchConnectivity

class InicialViewController: UIViewController, WCSessionDelegate {

    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!

    var totalProdutos : Double = 0
    var limite : Double = 0
    var nomeLista = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonOne.backgroundColor = UIColor.whiteColor()
        buttonOne.layer.cornerRadius = 27
        
        buttonTwo.backgroundColor = UIColor.whiteColor()
        buttonTwo.layer.cornerRadius = 27
        
        button3.backgroundColor = UIColor.whiteColor()
        button3.layer.cornerRadius = 27
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        
    }
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        
        if let valorTotalProdutos = message["totalProdutos"] as? Double {
            totalProdutos = valorTotalProdutos
        }
        if let valorLimiteLista = message["limiteLista"] as? Double{
            limite = valorLimiteLista
        }
        if let nomeL = message["nomeLista"] as? String{
            nomeLista = nomeL
            
            let data = NSDate()
            var lista: Lista!
            var produto: Produtos!
            
            lista = ListaManager.sharedInstance.novaLista()
            produto = ProdutoManager.sharedInstance.novoProduto()
            
            produto.nome = ""
            produto.valor = totalProdutos
            produto.quantidade = 1
            produto.lista = lista
            
            lista.nome = nomeLista
            lista.data = data
            lista.limite = limite
            
            ListaManager.sharedInstance.save()
        }
    }

}
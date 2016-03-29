//
//  ViewInicialTableViewController.swift
//  control
//
//  Created by Amanda Campos on 14/03/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewInicialTableViewController: UITableViewController, WCSessionDelegate {
    
    var totalProdutos : Double = 0
    var limite : Double = 0
    var nomeLista = ""
    
    @IBOutlet weak var labelInicial: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Configurações da Navigation
        navigationController?.navigationBarHidden = true
        navigationController!.navigationBar.tintColor = UIColor(red: 27/255, green: 188/255, blue: 155/255, alpha: 0.8)
        
        //design dos botões iniciais
        labelInicial.layer.cornerRadius = 230/2
        labelInicial.layer.borderColor = UIColor.whiteColor().CGColor
        labelInicial.layer.backgroundColor = UIColor(red: 27/255, green: 188/255, blue: 155/255, alpha: 0.8).CGColor
        
        labelInicial.layer.shadowColor = UIColor.blackColor().CGColor
        labelInicial.layer.shadowOffset = CGSizeZero
        labelInicial.layer.shadowOpacity = 3
        labelInicial.layer.masksToBounds = false
        
        WCSession.defaultSession().delegate = self
        WCSession.defaultSession().activateSession()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        //        super.viewWillAppear(animated)
        navigationController?.navigationBarHidden = true
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
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "listaDeGastos"{
            segue.destinationViewController as! ListaDeGastosTableViewController
        }
    }
}

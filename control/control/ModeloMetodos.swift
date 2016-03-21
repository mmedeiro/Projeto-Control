//
//  ModeloMetodos.swift
//  control
//
//  Created by Amanda Campos on 13/03/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit

class ModeloMetodos: NSObject {
    
    //bugou
    
    func designBotao(preco: UILabel) {
        
        preco.shadowColor = UIColor.blackColor()
        preco.shadowOffset = CGSizeZero
        
        preco.layer.cornerRadius = 125/2
        preco.layer.borderColor = UIColor.whiteColor().CGColor
        preco.layer.backgroundColor = UIColor(red: 27/255, green: 188/255, blue: 155/255, alpha: 0.8).CGColor
        
        preco.layer.shadowColor = UIColor.blackColor().CGColor
        preco.layer.shadowOffset = CGSizeZero
        preco.layer.shadowOpacity = 3
        preco.layer.masksToBounds = false
    }
    
    func finalizarLista(navigation: UINavigationController, view: UIViewController, arrayNomeLista: Array<String>, lista: Lista, tipo: String){
        let alertaNovoLimite = UIAlertController(title: nil, message: "Digite um novo nome para sua comanda", preferredStyle: .Alert)
        var limiteTxtField = UITextField()
        
        alertaNovoLimite.addTextFieldWithConfigurationHandler { (textField) -> Void in
            limiteTxtField = textField
            textField.placeholder = "Nome da comanda"
            textField.keyboardType = .Default
        }
        
        alertaNovoLimite.view.layer.shadowColor = UIColor.blackColor().CGColor
        alertaNovoLimite.view.layer.shadowOffset = CGSizeZero
        alertaNovoLimite.view.layer.shadowOpacity = 1
        
        let cancelar = UIAlertAction(title: "Cancelar", style: .Cancel, handler: nil)
        let salvar = UIAlertAction(title: "Salvar", style: .Default, handler: { (ACTION) -> Void in
            
            //salvar no coreData e redirecionar para a lista
            let date = NSDate()
            
            //            let dataEntrega = NSDateFormatter()
            //            dataEntrega.dateFormat = "dd/MM/yyyy"
            //            let dataString = dataEntrega.stringFromDate(date)
            //            let dd = dataEntrega.dateFromString(dataString)
            
            //salva lista
            lista.nome = limiteTxtField.text
            lista.data = date
            
            if tipo == "ilimitado"{
                lista.limite = 0
            }
            
            ListaManager.sharedInstance.save()
                        
            navigation.popToViewController(view, animated: true)
            
            if limiteTxtField.text != "Nome da comanda"{
                self.transferenciaDeDados(view, navigation: navigation, arrayNomeLista: arrayNomeLista)
            }
        })
        
        alertaNovoLimite.addAction(cancelar)
        alertaNovoLimite.addAction(salvar)
        
        view.presentViewController(alertaNovoLimite, animated: true, completion: nil)
    }
    
    func transferenciaDeDados(view: UIViewController, navigation: UINavigationController, arrayNomeLista: Array<String>){
        //transferir dados de uma view para outra apos executar o AlertController
        let secondViewController = view.storyboard!.instantiateViewControllerWithIdentifier("teste") as! ListaDeGastosTableViewController
        secondViewController.arrayLista = arrayNomeLista
        navigation.pushViewController(secondViewController, animated: true)
    }
    
    func salvarDemaisItens(index: NSIndexPath, arrayNome: Array<String>, valor: Float, lista: Lista!){
        
        //lista -> arrayProd -> procurar o produto -> atualizar valor
            
    }
}

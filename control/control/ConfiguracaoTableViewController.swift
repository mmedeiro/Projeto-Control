//
//  ConfiguracaoTableViewController.swift
//  control
//
//  Created by Amanda Campos on 19/04/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//
import Foundation
import UIKit
import MessageUI

class ConfiguracaoTableViewController: UITableViewController, MFMailComposeViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //configuração da navigation
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: .Default)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 40/255, green: 137/255, blue: 104/255, alpha: 1)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        //configuração da navigation
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: .Default)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 40/255, green: 137/255, blue: 104/255, alpha: 1)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func apagarTudo(sender: AnyObject) {
        let alerta = UIAlertController(title: "Atenção", message: "Você tem certeza que deseja apagar todos os seus dados?", preferredStyle: .Alert)
        let cancelar = UIAlertAction(title: "Cancelar", style: .Cancel, handler: nil)
        let apagar = UIAlertAction(title: "Apagar", style: .Destructive) { (action) in
            ListaManager.sharedInstance.deleteAll()
            ListaManager.sharedInstance.save()
            
            let alertOK = UIAlertController(title: "Sucesso", message: "Seus dados foram excluídos com sucesso", preferredStyle: .Alert)
            let ok = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertOK.addAction(ok)
            self.presentViewController(alertOK, animated: true, completion: nil)
        }
        
        alerta.addAction(cancelar)
        alerta.addAction(apagar)
        
        self.presentViewController(alerta, animated: true, completion: nil)
    }
    
    @IBAction func curtirFB(sender: AnyObject) {
        let url = NSURL(string: "http://facebook.com/1757915864423766")
        if UIApplication.sharedApplication().canOpenURL(url!) {
            UIApplication.sharedApplication().openURL(url!)
        } else {
            errorURL()
        }
    }
    
    @IBAction func avaliarAppStore(sender: AnyObject) {
        let url = NSURL(string: "https://itunes.apple.com/us/app/24-s-wt-h-plyqzyh-hyhydh-smqry/id1098887721?ls=1&mt=8")
        if UIApplication.sharedApplication().canOpenURL(url!) {
            UIApplication.sharedApplication().openURL(url!)
        } else {
            errorURL()
        }
    }
    
    @IBAction func contato(sender: AnyObject) {
        if MFMailComposeViewController.canSendMail(){
            let picker = MFMailComposeViewController()
            
            picker.mailComposeDelegate = self
            picker.setSubject("Aplicativo Minha Comanda")
            picker.setToRecipients(["amanda96campos@gmail.com"])
            picker.setMessageBody("Olá, gostaria de informar...", isHTML: true)
            
            presentViewController(picker, animated: true, completion: nil)
        } else {
            let alerta = UIAlertController(title: "Erro", message: "Verifique seu email nas configurações", preferredStyle: .Alert)
            let ok = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
            
            alerta.addAction(ok)
            
            self.presentViewController(alerta, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func errorURL(){
        let alerta = UIAlertController(title: "Erro", message: "Não foi possível concluir essa ação, tente novamente mais tarde.", preferredStyle: .Alert)
        let ok = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
        
        alerta.addAction(ok)
        
        self.presentViewController(alerta, animated: true, completion: nil)
    }
}

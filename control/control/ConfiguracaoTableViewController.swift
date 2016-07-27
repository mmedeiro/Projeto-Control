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
        let alerta = UIAlertController(title: NSLocalizedString("atencao", comment: "atencao"), message: NSLocalizedString("alerta_apaga_tudo", comment: "alerta_msg"), preferredStyle: .Alert)
        let cancelar = UIAlertAction(title: NSLocalizedString("cancelar", comment: "Cancel"), style: .Cancel, handler: nil)
        let apagar = UIAlertAction(title: NSLocalizedString("apagar", comment: "apagar"), style: .Destructive) { (action) in
            ListaManager.sharedInstance.deleteAll()
            ListaManager.sharedInstance.save()
            
            let alertOK = UIAlertController(title: NSLocalizedString("sucesso", comment: "sucesso"), message: NSLocalizedString("alerta_dados_apagados", comment: "msg"), preferredStyle: .Alert)
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
            picker.setSubject(NSLocalizedString("email_assunto", comment: "assunto"))
            picker.setToRecipients(["amanda96campos@gmail.com", "mariisabele.19@gmail.com"])
            picker.setMessageBody(NSLocalizedString("email_msg=", comment: "msg"), isHTML: true)
            
            presentViewController(picker, animated: true, completion: nil)
        } else {
            let alerta = UIAlertController(title: NSLocalizedString("erro", comment: "erro"), message: NSLocalizedString("alerta_erro_email", comment: "msg"), preferredStyle: .Alert)
            let ok = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
            
            alerta.addAction(ok)
            
            self.presentViewController(alerta, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func errorURL(){
        let alerta = UIAlertController(title: NSLocalizedString("erro", comment: "erro"), message: NSLocalizedString("alerta_erro", comment: "msg"), preferredStyle: .Alert)
        let ok = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
        
        alerta.addAction(ok)
        
        self.presentViewController(alerta, animated: true, completion: nil)
    }
}

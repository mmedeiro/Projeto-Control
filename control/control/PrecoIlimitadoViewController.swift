//
//  PrecoIlimitadoViewController.swift
//  control
//
//  Created by Amanda Campos on 11/03/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit

class PrecoIlimitadoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let mm = ModeloMetodos()
    let img = UIImage(named: "backButton") as UIImage?
    var lista: Lista!
    var arrayNomeLista: Array<String> = []
    var produto : Produtos!
    var produtos:[Produtos] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalDaComanda: UILabel!
    @IBOutlet weak var finalizarCompras: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //configuração da navigation 
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: .Default)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 40/255, green: 137/255, blue: 104/255, alpha: 1)

        finalizarCompras.enabled = false
        
        //inicializa lista
        self.lista = ListaManager.sharedInstance.novaLista()
        self.lista.nome = nil
        
    }
    
    override func viewWillAppear(animated: Bool) {
        //configuração da tabBar e Navigation
        self.tabBarController?.tabBar.hidden = true
        
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: .Default)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 40/255, green: 137/255, blue: 104/255, alpha: 1)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return produtos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCellWithIdentifier("celula", forIndexPath: indexPath) as! PrecoIlimitadoTableViewCell
        
        cell.nomeItemIlimitado.text = produtos[indexPath.row].nome?.capitalizedString
        cell.precoItemIlimitado.text  = "\(produtos[indexPath.row].valor!)"
        cell.quantidadeLabel.text = "\(produtos[indexPath.row].quantidade!) x"
        
        self.incrementar()
        
        if totalDaComanda.text != "R$"{
            finalizarCompras.enabled = true
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let maisUm = UITableViewRowAction(style: .Normal, title: "+1") { (action, index) -> Void in
            tableView.editing = false
            
            var valor = self.produtos[indexPath.row].valor
            var quantidade = self.produtos[indexPath.row].quantidade
            
            
            valor = Double(valor!) / Double(quantidade!)
            quantidade = Double(quantidade!) + 1
            valor = Double(valor!) * Double(quantidade!)
            
            self.produtos[indexPath.row].valor = valor
            self.produtos[indexPath.row].quantidade = quantidade
            ProdutoManager.sharedInstance.save()
            
            self.tableView.reloadData()
        }
        
        maisUm.backgroundColor = UIColor(red: 153/255, green: 179/255, blue: 194/255, alpha: 1)
        
        let deletar = UITableViewRowAction(style: .Default, title: "-1") { (action, index) in
            let produt = self.produtos[indexPath.row]

            if Double(self.produtos[indexPath.row].quantidade!) == 1{
            self.produtos.removeAtIndex(indexPath.row)
            }

            ProdutoManager.sharedInstance.deletarUmProduto(produt)
            
            self.tableView.reloadData()
        }
        
        return [deletar, maisUm]
    }
    
    @IBAction func adcItem(sender: AnyObject) {
        let alertaNovoItem = UIAlertController(title: nil, message: "", preferredStyle: .Alert)
        var descricaoTxtField = UITextField()
        var precoTxtField = UITextField()
        
        alertaNovoItem.addTextFieldWithConfigurationHandler { (textField) -> Void in
            descricaoTxtField = textField
            textField.placeholder = "Nome do item"
            textField.keyboardType = .Default
            
        }
                
        alertaNovoItem.addTextFieldWithConfigurationHandler { (textField) -> Void in
            precoTxtField = textField
            textField.placeholder = "Valor"
            textField.keyboardType = .DecimalPad
        }
        
        alertaNovoItem.view.layer.shadowColor = UIColor.blackColor().CGColor
        alertaNovoItem.view.layer.shadowOffset = CGSizeZero
        alertaNovoItem.view.layer.shadowOpacity = 1
        
        let cancelar = UIAlertAction(title: "Cancelar", style: .Cancel, handler: nil)
        let salvar = UIAlertAction(title: "Salvar", style: .Default, handler: { (ACTION) -> Void in
            
            if precoTxtField.text == "" {
                
                let alertaCampoVazio = UIAlertController(title: nil, message: "Defina o valor do produto", preferredStyle: .Alert)
                alertaCampoVazio.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                self.presentViewController(alertaCampoVazio, animated: true, completion: nil)
                
            } else {
                
                let formatarNumero = (precoTxtField.text)?.stringByReplacingOccurrencesOfString(",", withString: ".")
                
                //salva apenas o primeiro produto
                self.produto = ProdutoManager.sharedInstance.novoProduto()
                
                if descricaoTxtField.text != ""{
                
                    self.produto.nome = descricaoTxtField.text
                } else {
                    
                    self.produto.nome = "Produto"
                }
                
                if let numFormatado = formatarNumero{
                    self.produto.valor = Double(numFormatado)
                }
                self.produto.quantidade = 1
                self.produto.lista = self.lista
                
                ProdutoManager.sharedInstance.save()
                
                self.produtos.append(self.produto)
                
                self.navigationController?.popToViewController(self, animated: true)
                
                self.tableView.reloadData()
            }
        })
        
        alertaNovoItem.addAction(cancelar)
        alertaNovoItem.addAction(salvar)
        
        self.presentViewController(alertaNovoItem, animated: true, completion: nil)
    }
    
    @IBAction func finalizarComanda(sender: AnyObject){
        mm.finalizarLista(navigationController!, view: self, arrayNomeLista: arrayNomeLista, lista: self.lista, tipo: "ilimitado")
    }
    
    func incrementar(){
        var soma: Double = 0
                for i in produtos{
                    soma = soma + Double(i.valor!)
                }
        totalDaComanda.text = "\(soma)"
    }
}

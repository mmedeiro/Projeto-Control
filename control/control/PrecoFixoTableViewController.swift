//
//  PrecoFixoTableViewController.swift
//  control
//
//  Created by Amanda Campos on 05/02/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit

class PrecoFixoTableViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var lista: Lista!
    var produto: Produtos!
    var mm = ModeloMetodos()
    var produtos:[Produtos] = []
    var precoFake = String()
    var arrayNomeLista: Array<String> = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var precoEscolhido: UILabel!
    @IBOutlet weak var buttonAddItem: UIBarButtonItem!
    @IBOutlet weak var buttonFinalizarItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //configuração para cor da navigation
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: .Default)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 40/255, green: 137/255, blue: 104/255, alpha: 1)
        
        valorDoLimite()
        
        //botão adc item e finalizar lista hidden
        buttonFinalizarItem.enabled = false
        buttonAddItem.enabled = false
        
        self.lista = ListaManager.sharedInstance.novaLista()
        self.lista.nome = nil
        
    }
    
    //conf. tabBar
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = true
        
        //configuração para cor da navigation
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: .Default)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 40/255, green: 137/255, blue: 104/255, alpha: 1)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return produtos.count
    }
    
    //configuração das label na celula
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: PrecoFixoDetalhesTableViewCell = tableView.dequeueReusableCellWithIdentifier("celula", forIndexPath: indexPath) as! PrecoFixoDetalhesTableViewCell
        
        cell.descricaoLabel.text = produtos[indexPath.row].nome!.capitalizedString
        cell.quantidadeLabel.text = "\(produtos[indexPath.row].quantidade!) x"
//        if let numFormatado = produtos[indexPath.row].valor{
        cell.precoLabel.text = "\(produtos[indexPath.row].valor!)"
//        }
        
        //decrementa o preço inserido do preço total
        decrementar()
        
        return cell
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        //caso queria adicionar o mesmo produto mais uma vez
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
        
        //caso queira tirar um produto
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
    
    //decrementa o preço inserido do preço total
    func decrementar(){
        let valorInicial = Double(precoFake)
        var valorInicialAlterado = valorInicial!
        for i in produtos{
            valorInicialAlterado = valorInicialAlterado - Double(i.valor!)
        }
        
        precoEscolhido.text? = "\(valorInicialAlterado)"
    }
    
    //alerta para adicionar nome do produto e preço
    @IBAction func adcItem(sender: AnyObject) {
        
        let alertaNovoItem = UIAlertController(title: nil, message: "", preferredStyle: .Alert)
        var descricaoTxtField = UITextField()
        var precoTxtField = UITextField()
        
        alertaNovoItem.addTextFieldWithConfigurationHandler { (textField) -> Void in
            descricaoTxtField = textField
            textField.placeholder = NSLocalizedString("item_nome", comment: "Product Name")
            textField.keyboardType = .Default
        }
        
        alertaNovoItem.addTextFieldWithConfigurationHandler { (textField) -> Void in
            precoTxtField = textField
            textField.placeholder = NSLocalizedString("valor", comment: "Price")
            textField.keyboardType = .DecimalPad
        }
        
        alertaNovoItem.view.layer.shadowColor = UIColor.blackColor().CGColor
        alertaNovoItem.view.layer.shadowOffset = CGSizeZero
        alertaNovoItem.view.layer.shadowOpacity = 1
        
        let cancelar = UIAlertAction(title: NSLocalizedString("cancelar", comment: "Cancel"), style: .Cancel, handler: nil)
        let salvar = UIAlertAction(title: NSLocalizedString("salvar", comment: "Save"), style: .Default, handler: { (ACTION) -> Void in
            
            if precoTxtField.text == "" || precoTxtField == " "{
                
                let alertaCampoVazio = UIAlertController(title: nil, message: NSLocalizedString("defina_valor_produto", comment: "Set Value"), preferredStyle: .Alert)
                alertaCampoVazio.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                
                self.presentViewController(alertaCampoVazio, animated: true, completion: nil)
                
            } else {
                
                
                let formatarNumero = (precoTxtField.text)?.stringByReplacingOccurrencesOfString(",", withString: ".")
                
                
                self.produto = ProdutoManager.sharedInstance.novoProduto()
                
                if descricaoTxtField.text != "" {
                    self.produto.nome = descricaoTxtField.text
                } else  {
                    self.produto.nome = NSLocalizedString("produto_sem_descricao", comment: "No Description")
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
    
    @IBAction func alterarLimite(sender: AnyObject) { valorDoLimite() }
    
    //alterar limite
    func valorDoLimite(){
        let alertaNovoLimite = UIAlertController(title: nil, message: NSLocalizedString("defina_o_limite", comment: "Limit Def"), preferredStyle: .Alert)
        var limiteTxtField = UITextField()
        
        alertaNovoLimite.addTextFieldWithConfigurationHandler { (textField) -> Void in
            limiteTxtField = textField
            textField.placeholder = NSLocalizedString("valor", comment: "Price")
            textField.keyboardType = .DecimalPad
        }
        
        alertaNovoLimite.view.layer.shadowColor = UIColor.blackColor().CGColor
        alertaNovoLimite.view.layer.shadowOffset = CGSizeZero
        alertaNovoLimite.view.layer.shadowOpacity = 1
        
        let cancelar = UIAlertAction(title: NSLocalizedString("cancelar", comment: "Cancel"), style: .Cancel, handler: nil)
        let salvar = UIAlertAction(title: NSLocalizedString("salvar", comment: "Save"), style: .Default, handler: { (ACTION) -> Void in
            
            if limiteTxtField.text == "" {
                
                let alertaSemLimite = UIAlertController(title: nil, message: NSLocalizedString("defina_o_limite", comment: "Def Lim"), preferredStyle: .Alert)
                alertaSemLimite.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                self.presentViewController(alertaSemLimite, animated: true, completion: nil)
                
            } else {
                
                let formatarNumero = (limiteTxtField.text)?.stringByReplacingOccurrencesOfString(",", withString: ".")
                
                if limiteTxtField.text == "0" || limiteTxtField.text == "" {
                    self.buttonFinalizarItem.enabled = false
                    self.buttonAddItem.enabled = false
                    self.precoEscolhido.text = NSLocalizedString("moeda", comment: "$")
                    
                } else {
                    self.buttonFinalizarItem.enabled = true
                    self.buttonAddItem.enabled = true
                    self.precoFake = formatarNumero!
                    self.precoEscolhido.text? = NSLocalizedString("moeda \(self.precoFake)", comment: "$")
                    self.decrementar()
                }
                
                self.lista.limite = Double(self.precoFake)
                
                self.navigationController?.popToViewController(self, animated: true)
            }
        })
        
        alertaNovoLimite.addAction(cancelar)
        alertaNovoLimite.addAction(salvar)
        
        self.presentViewController(alertaNovoLimite, animated: true, completion: nil)
    }
    
    @IBAction func finalizar(sender: AnyObject) {
        mm.finalizarLista(navigationController!, view: self, arrayNomeLista: arrayNomeLista, lista: self.lista, tipo: "limitado")
    }
    
    
}

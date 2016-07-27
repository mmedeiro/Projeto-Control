//
//  ListaDeGastosTableViewController.swift
//  control
//
//  Created by Amanda Campos on 14/03/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit

class ListaDeGastosTableViewController: UITableViewController {
    
    var arrayLista: Array<String> = []
    var arrayData: Array<String> = []
    var arrayTotal: Array<String> = []
    var listas: [Lista] = []
    var lista: Lista!
    var soma: Double!
    var count = 0
    var labelNenhumaLista: UILabel = UILabel()
    let img = UIImage(named: "back") as UIImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //configuração da navigation
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: .Default)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 40/255, green: 137/255, blue: 104/255, alpha: 1)

        //conf. do botão de voltar na navigation
        let myBackButton:UIButton = UIButton(type: UIButtonType.Custom)
        myBackButton.addTarget(self, action: #selector(ListaDeGastosTableViewController.popToRoot(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        myBackButton.setImage(img, forState: UIControlState.Normal)
        myBackButton.setTitle(NSLocalizedString("inicial_back_button", comment: "Back"), forState: UIControlState.Normal)
        myBackButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        myBackButton.sizeToFit()
        let myCustomBackButtonItem:UIBarButtonItem = UIBarButtonItem(customView: myBackButton)
        self.navigationItem.leftBarButtonItem  = myCustomBackButtonItem
        
        listas = ListaManager.sharedInstance.buscarListas()
        verificarLista()
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        for listaIndex in ListaManager.sharedInstance.buscarListas(){
            soma = 0
            
            if  listaIndex.nome == nil {
                listas.removeAtIndex(count)
                ListaManager.sharedInstance.delete(listaIndex)
                ListaManager.sharedInstance.save()
            } else {
                
                let dataEntrega = NSDateFormatter()
                dataEntrega.dateFormat = NSLocalizedString("data_hora", comment: "data e hora")
                let dataString = dataEntrega.stringFromDate(listaIndex.data!)
                
                arrayLista.append(listaIndex.nome!)
                arrayData.append(dataString)
                for produtoIndex in ProdutoManager.sharedInstance.buscarProdutos(){
                    if produtoIndex.lista!.objectID == listaIndex.objectID{
                        
                        soma = soma + Double(produtoIndex.valor!)
                    }
                }
                arrayTotal.append("\(soma)")
                count += 1
            }
        }
        
        self.tableView.reloadData()
    }
    
    private func FormatDate(date:NSDate) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        return dateFormatter.stringFromDate(date)
    }
    
    func verificarLista(){
        if listas.count == 0{
            labelNenhumaLista.frame = CGRect(x: 0, y: tableView.frame.size.height/2 - 40, width: tableView.frame.size.width, height: 30)
            labelNenhumaLista.text = NSLocalizedString("nenhuma_lista", comment: "Sem registro")
            labelNenhumaLista.textAlignment = .Center
            labelNenhumaLista.numberOfLines = 3
            labelNenhumaLista.textColor = UIColor.whiteColor()
            labelNenhumaLista.adjustsFontSizeToFitWidth = true
            self.tableView.addSubview(labelNenhumaLista)
        } else {
            self.tableView.removeFromSuperview()
        }
    }
    
    func popToRoot(sender:UIBarButtonItem){
        self.navigationController!.popToRootViewControllerAnimated(true)
    }
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listas.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("celula", forIndexPath: indexPath) as! ListaDeGastosTableViewCell
        
        
        cell.nomeDaLista.text = listas[indexPath.row].nome?.capitalizedString
        cell.totalDaLista.text = arrayTotal[indexPath.row]
        cell.dataDaLista.text? = arrayData[indexPath.row]
        
        return cell
    }
    

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Deletar lista
            let list = listas[indexPath.row]
            arrayLista.removeAtIndex(indexPath.row)
            listas.removeAtIndex(indexPath.row)
            ListaManager.sharedInstance.delete(list)
            ListaManager.sharedInstance.save()
        }
        
        listas = ListaManager.sharedInstance.buscarListas()
        
        self.tableView.reloadData()
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "dadosLista" {
            let destino = segue.destinationViewController as! DetalhesListaViewController
            let cell = sender as! UITableViewCell
            let indexPath = self.tableView.indexPathForCell(cell)
            let objeto = listas[(indexPath?.row)!]
            destino.lista = objeto
            destino.indice = indexPath?.row
        }
    }
    
}

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
    var img = UIImage(named: "backButton") as UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBarHidden = false
        
        let myBackButton:UIButton = UIButton(type: UIButtonType.Custom)
        myBackButton.addTarget(self, action: #selector(ListaDeGastosTableViewController.popToRoot(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        myBackButton.setImage(img, forState: UIControlState.Normal)
        myBackButton.setTitle("Home", forState: UIControlState.Normal)
        myBackButton.setTitleColor(UIColor(red: 27/255, green: 188/255, blue: 155/255, alpha: 0.8), forState: UIControlState.Normal)
        myBackButton.sizeToFit()
        let myCustomBackButtonItem:UIBarButtonItem = UIBarButtonItem(customView: myBackButton)
        self.navigationItem.leftBarButtonItem  = myCustomBackButtonItem
        
        listas = ListaManager.sharedInstance.buscarListas()
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        for listaIndex in ListaManager.sharedInstance.buscarListas(){
            soma = 0
            print(listaIndex.nome)
            
            if  listaIndex.nome == nil {
                listas.removeAtIndex(count)
                ListaManager.sharedInstance.delete(listaIndex)
                ListaManager.sharedInstance.save()
            } else {
                
                arrayLista.append(listaIndex.nome!)
                arrayData.append("\(listaIndex.data!)")
                for produtoIndex in ProdutoManager.sharedInstance.buscarProdutos(){
                    if produtoIndex.lista!.objectID == listaIndex.objectID{
                        
                        soma = soma + Double(produtoIndex.valor!)
                        print(soma)
                    }
                }
                arrayTotal.append("\(soma)")
                count += 1
            }
        }
        
        self.tableView.reloadData()
    }
    
    override func viewWillDisappear(animated: Bool) {
        //        self.navigationController!.popToRootViewControllerAnimated(true)
        
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
        cell.dataDaLista.text = "\(listas[indexPath.row].data)"
        
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
    
    func popToRoot(sender:UIBarButtonItem){
        self.navigationController!.popToRootViewControllerAnimated(true)
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

//
//  DetalhesListaViewController.swift
//  control
//
//  Created by Mariana Medeiro on 17/03/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit

class DetalhesListaViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var produtos: [Produtos] = []
    var lista: Lista!
    var indice: Int!
    var soma: Double!
    @IBOutlet weak var valorLimite: UILabel!
    @IBOutlet weak var valorGasto: UILabel!
    @IBOutlet weak var dataLista: UILabel!
    @IBOutlet weak var nomeLista: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        soma = 0
        
        nomeLista.text = lista.nome?.capitalizedString
        dataLista.text = "\(lista.data)"
        
        produtos = lista.produtos?.allObjects as! [Produtos]
        
        for i in produtos{
            soma = soma + Double(i.valor!)
            print("nova soma: ", soma)
        }
        
        if lista.limite == 0 {
            valorLimite.hidden = true
            valorGasto.text = "Total: \(soma)"
        } else {
            if soma > Double(lista.limite!){
                valorLimite.text = "Você ultrapassou seu" + " limite inicial de R$ \(lista.limite)"
                valorGasto.text = "Total: \(soma)"
            } else {
                valorLimite.text = "Parabéns, você não ultrapassou"+" seu limite de R$ \(lista.limite)"
                valorGasto.text = "Total: \(soma)"
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
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
        
        let cell = tableView.dequeueReusableCellWithIdentifier("celula", forIndexPath: indexPath) as! DetalheListaTableViewCell
        
        cell.nomeProduto.text = produtos[indexPath.row].nome?.capitalizedString
        
        if let valorFormatada = produtos[indexPath.row].valor{
            cell.valorProduto.text = String(valorFormatada)
        }
        
        if let quantidadeFormatada = produtos[indexPath.row].quantidade{
            cell.qtdProduto.text = "\(quantidadeFormatada)"
        }
        
        return cell
    }
}

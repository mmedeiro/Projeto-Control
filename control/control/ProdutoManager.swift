//
//  ProdutoManager.swift
//  control
//
//  Created by Mariana Medeiro on 15/03/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class ProdutoManager {
    
    static let sharedInstance = ProdutoManager()
    static let entityName:String = "Produtos"
    
    lazy var manegedContext:NSManagedObjectContext = {
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var c = appDelegate.managedObjectContext
        return c!
    }()
    
    
    private init(){}
    
    
    func novoProduto()->Produtos{
        return NSEntityDescription.insertNewObjectForEntityForName(ProdutoManager.entityName, inManagedObjectContext: manegedContext) as! Produtos
    }
    
    func buscarProdutos()->Array<Produtos>{
        let fetchRequest = NSFetchRequest(entityName: ProdutoManager.entityName)
        
        do{
        let fetchedResults = try manegedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
        
        if let results = fetchedResults as? [Produtos] {
            return results
        } else {
            print("Could not fetch")
        }
            
        } catch {
            print("Error")
        }
        return Array<Produtos>()
    }
    
    func save(){
        do{
            try manegedContext.save()
            print("Salvou Produto")
        }
        catch{
            print("Deu ruim")
        }
    }

}

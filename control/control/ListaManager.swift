//
//  ListaManager.swift
//  control
//
//  Created by Mariana Medeiro on 15/03/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class ListaManager {
    
    static let sharedInstance = ListaManager()
    static let entityName:String = "Lista"
    
    lazy var manegedContext:NSManagedObjectContext = {
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var c = appDelegate.managedObjectContext
        return c!
    }()
    
    
    private init(){}
    
    
    func novaLista() -> Lista{
        return NSEntityDescription.insertNewObjectForEntityForName(ListaManager.entityName, inManagedObjectContext: manegedContext) as! Lista
    }
    
    func buscarListas()->Array<Lista>{
        let fetchRequest = NSFetchRequest(entityName: ListaManager.entityName)
        
        do{
            let fetchedResults = try manegedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
            
            if let results = fetchedResults as? [Lista] {
                return results
            } else {
                print("Could not fetch")
            }
            
        } catch {
            print("Error")
        }
        
        return Array<Lista>()
    }
    
    func save(){
        do{
            try manegedContext.save()
            print("Salvou Lista")
        }
        catch{
            print("Não Salvou a lista")
        }
    }
    
    func delete(lista: Lista){
            manegedContext.deleteObject(lista)
            save()
            print("deletou Lista")
    }
    
    func deleteAll(){
        let fd = NSFetchRequest(entityName: ListaManager.entityName)
        
        do {
            let fetchedResults = try manegedContext.executeFetchRequest(fd) as? [NSManagedObject]
            
            if let results = fetchedResults as? [Lista] {
                
                for message in results {
                    
                    manegedContext.deleteObject(message)
                    print(message)
                }
            }
        }
        catch {
            print("miss")
        }
    }
}



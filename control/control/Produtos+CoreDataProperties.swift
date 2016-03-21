//
//  Produtos+CoreDataProperties.swift
//  control
//
//  Created by Amanda Campos on 17/03/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Produtos {

    @NSManaged var nome: String?
    @NSManaged var valor: NSNumber?
    @NSManaged var quantidade: NSNumber?
    @NSManaged var lista: Lista?

}

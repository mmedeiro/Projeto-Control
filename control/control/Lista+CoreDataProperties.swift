//
//  Lista+CoreDataProperties.swift
//  control
//
//  Created by Mariana Medeiro on 15/03/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Lista {

    @NSManaged var limite: NSNumber?
    @NSManaged var data: NSDate?
    @NSManaged var nome: String?
    @NSManaged var produtos: NSSet?

}

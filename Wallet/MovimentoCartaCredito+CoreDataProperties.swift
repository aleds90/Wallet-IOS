//
//  MovimentoCartaCredito+CoreDataProperties.swift
//  Wallet
//
//  Created by Estia on 04/07/16.
//  Copyright © 2016 AleMarco. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension MovimentoCartaCredito {

    @NSManaged var id: NSNumber?
    @NSManaged var nome: String?
    @NSManaged var importo: NSNumber?
    @NSManaged var data: NSDate?
    @NSManaged var causale: Causale?
    @NSManaged var cartaCredito: CartaCredito?

}

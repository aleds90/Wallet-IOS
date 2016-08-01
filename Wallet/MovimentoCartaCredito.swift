//
//  MovimentoCartaCredito.swift
//  Wallet
//
//  Created by Estia on 04/07/16.
//  Copyright © 2016 AleMarco. All rights reserved.
//

import Foundation
import CoreData


class MovimentoCartaCredito: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    
    class func createInManagedObjectContext(moc: NSManagedObjectContext, nome: String, importo: Int, data: NSDate, casuale: Causale?, cartacredito: CartaCredito) -> MovimentoCartaCredito {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("MovimentoCartaCredito", inManagedObjectContext: moc) as! MovimentoCartaCredito
        newItem.nome = nome
        newItem.importo = importo
        newItem.data = data
        newItem.causale = casuale
        newItem.cartaCredito = cartacredito
        do{
            try moc.save()
        }catch let error as NSError{
            print("Could not save \(error), \(error.userInfo)")
        }
        return newItem
    }

}

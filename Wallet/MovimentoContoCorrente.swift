//
//  MovimentoContoCorrente.swift
//  Wallet
//
//  Created by Estia on 04/07/16.
//  Copyright © 2016 AleMarco. All rights reserved.
//

import Foundation
import CoreData


class MovimentoContoCorrente: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    class func createInManagedObjectContext(moc: NSManagedObjectContext, nome: String, importo: Int, data: NSDate, rendicontato: NSNumber, casuale: Causale?, contoCorrente: ContoCorrente) -> MovimentoContoCorrente {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("MovimentoContoCorrente", inManagedObjectContext: moc) as! MovimentoContoCorrente
        newItem.nome = nome
        newItem.importo = importo
        newItem.data = data
        newItem.rendicontato = rendicontato
        newItem.causale = casuale
        newItem.contoCorrente = contoCorrente
        do{
            try moc.save()
        }catch let error as NSError{
            print("Could not save \(error), \(error.userInfo)")
        }
        return newItem
    }

}

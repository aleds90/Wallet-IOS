//
//  ContoCorrente.swift
//  Wallet
//
//  Created by Estia on 04/07/16.
//  Copyright © 2016 AleMarco. All rights reserved.
//

import Foundation
import CoreData


class ContoCorrente: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    class func createInManagedObjectContext(moc: NSManagedObjectContext, nome: String, importo: NSNumber, tipoconto: TipoConto) -> ContoCorrente {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("ContoCorrente", inManagedObjectContext: moc) as! ContoCorrente
        newItem.nome = nome
        newItem.importo = importo
        newItem.tipoConto = tipoconto
        
        do{
            try moc.save()
            
        }catch let error as NSError{
            print("Could not save \(error), \(error.userInfo)")
        }
        
        return newItem
    }

}

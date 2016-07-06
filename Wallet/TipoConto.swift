//
//  TipoConto.swift
//  Wallet
//
//  Created by Estia on 04/07/16.
//  Copyright © 2016 AleMarco. All rights reserved.
//

import Foundation
import CoreData


class TipoConto: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    class func createInManagedObjectContext(moc: NSManagedObjectContext, nome: String) -> TipoConto {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("TipoConto", inManagedObjectContext: moc) as! TipoConto
        newItem.nome = nome
        do{
            try moc.save()
        }catch let error as NSError{
            print("Could not save \(error), \(error.userInfo)")
        }
        return newItem
    }


}

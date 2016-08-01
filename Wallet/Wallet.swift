//
//  Wallet.swift
//  Wallet
//
//  Created by Estia on 25/07/16.
//  Copyright © 2016 AleMarco. All rights reserved.
//

import Foundation

protocol Wallet {
    var id: NSNumber? {get set}
    var nome: String? {get set}
    var importo: NSNumber? {get set}
    
    init()
}
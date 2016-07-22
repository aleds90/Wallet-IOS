//
//  CellDeatilViewCell.swift
//  Wallet
//
//  Created by Estia on 22/07/16.
//  Copyright © 2016 AleMarco. All rights reserved.
//

import UIKit

class CellDeatilViewCell: UITableViewCell {

    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var importoLabel: UILabel!
    @IBOutlet weak var causaleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  ItemTableViewCell.swift
//  ServeSoup
//
//  Created by Jocelyn Stuart on 2/4/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    var item: Item? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let item = item else { return }
       
        itemNameLabel.text = item.name
        amountLabel.text = "Amount: \(item.amount)"
        
        if amountLabel.text == "Amount: 0" {
            restockLabel.alpha = 1
            restockLabel.textColor = .red
        } else {
            restockLabel.alpha = 0
        }
    }
    
    
    
    @IBOutlet weak var itemNameLabel: UILabel!
    
    @IBOutlet weak var amountLabel: UILabel!
    
    @IBOutlet weak var restockLabel: UILabel!
    
    

}

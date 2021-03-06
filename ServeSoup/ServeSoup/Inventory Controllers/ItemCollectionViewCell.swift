//
//  ItemCollectionViewCell.swift
//  ServeSoup
//
//  Created by Jocelyn Stuart on 2/5/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    var item: Item? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let item = item else { return }
        
       // let image = UIImage(
        
        itemNameLabel.textColor = AppearanceHelper.queenBlue
        amountLabel.textColor = AppearanceHelper.gunmetal
    
        itemNameLabel.text = item.name.uppercased()
        amountLabel.text = "Quantity: \(item.amount)"
       // itemImageView.image  = item.imageURL
        
        if amountLabel.text == "Quantity: 0" {
            restockLabel.alpha = 1
            restockLabel.textColor = .red
        } else {
            restockLabel.alpha = 0
        }
    }
    
    
    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var itemNameLabel: UILabel!
    
    @IBOutlet weak var amountLabel: UILabel!
    
    @IBOutlet weak var restockLabel: UILabel!
    
}

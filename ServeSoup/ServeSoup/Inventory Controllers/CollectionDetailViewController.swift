//
//  CollectionDetailViewController.swift
//  ServeSoup
//
//  Created by Jocelyn Stuart on 2/6/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class CollectionDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        AppearanceHelper.collectionAppearance()
        view.backgroundColor = AppearanceHelper.honeydew
        AppearanceHelper.styleTwo(button: deleteButton)
        
        itemLabel.textColor = AppearanceHelper.queenBlue
        quantityLabel.textColor = AppearanceHelper.queenBlue
        unitLabel.textColor = AppearanceHelper.queenBlue
        
        if navigationItem.title == "Add a New Item" {
            deleteButton.alpha = 0
        } else {
            deleteButton.alpha = 1
        }
        // Do any additional setup after loading the view.
    }
    
    var item: Item? {
        didSet {
            updateViews()
        }
    }
    var itemController: ItemController?
    
    
    func updateViews() {
        
        if let item = item, isViewLoaded {
            deleteButton.alpha = 1
            itemNameTextField.text = item.name.uppercased()
            amountTextField.text = String(item.amount)
            unitTextField.text = item.unit
            
            navigationItem.title = itemNameTextField.text
            
           
        } else {
            navigationItem.title = "Add a New Item"
           
        }
        
    }
    
    
    @IBOutlet weak var itemLabel: UILabel!
    
    @IBOutlet weak var quantityLabel: UILabel!
    
    @IBOutlet weak var unitLabel: UILabel!
    
    let inventoryCollectionView = InventoryCollectionViewController()
    
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var itemNameTextField: UITextField!
    
    @IBOutlet weak var amountTextField: UITextField!
    
    @IBOutlet weak var unitTextField: UITextField!
    
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        if let item = item {
            itemController?.delete(item: item) { (error) in
                if let error = error {
                    print(error)
                }
                DispatchQueue.main.async {
                   // self.inventoryCollectionView.collectionView.reloadData()
                    self.navigationController?.popViewController(animated: true)
                }
            }
        
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let name = itemNameTextField.text, let amount = amountTextField.text else { return }
        
        let number = Int.random(in: 0 ..< 10)
        
        if let item = item {
            itemController?.update(withItem: item, andName: name, andAmount: Int(amount)!, completion: { (error) in
                if let error = error {
                    print(error)
                }
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            })
            
        } else {
            print(name, amount)
            deleteButton.alpha = 1
            if unitTextField.text == "" {
                itemController?.createItem(withName: name, andAmount: Int(amount)!, andCategory: number, andUnit: nil, completion: { (error) in
                    if let error = error {
                        print(error)
                    }
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                })
            } else {
                itemController?.createItem(withName: name, andAmount: Int(amount)!, andCategory: number, andUnit: unitTextField.text, completion: { (error) in
                    if let error = error {
                        print(error)
                    }
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                })
            }
           
        }
    }
    
    

}

//
//  ItemDetailViewController.swift
//  ServeSoup
//
//  Created by Jocelyn Stuart on 2/4/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
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
            itemNameTextField.text = item.name
            amountTextField.text = String(item.amount)
            unitTextField.text = item.unit
            
            navigationItem.title = itemNameTextField.text
            
            
        } else {
            navigationItem.title = "Add a New Item"
        }
        
    }
    
    @IBOutlet weak var itemNameTextField: UITextField!
    
   
    @IBOutlet weak var amountTextField: UITextField!
    
    
    @IBOutlet weak var unitTextField: UITextField!
    
    
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

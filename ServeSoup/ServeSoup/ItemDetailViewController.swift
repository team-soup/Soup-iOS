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

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBOutlet weak var itemNameTextField: UITextField!
    
   
    @IBOutlet weak var amountTextField: UITextField!
    
    
    @IBOutlet weak var unitTextField: UITextField!
    
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
    }
    
}

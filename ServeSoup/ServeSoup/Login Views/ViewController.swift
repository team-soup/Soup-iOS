//
//  ViewController.swift
//  ServeSoup
//
//  Created by Jocelyn Stuart on 2/4/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        view.backgroundColor = AppearanceHelper.honeydew
        AppearanceHelper.style(button: loginButton)
        AppearanceHelper.style(button: signUpButton)
        
        self.navigationItem.setHidesBackButton(true, animated:true);
        
    }
    
    func saveData () {
        self.performSegue(withIdentifier: "loggedin", sender: self)
    }
    
    let userController = UserController()

    @IBOutlet weak var soupKitchenLabel: UILabel!
    @IBOutlet weak var adminPanelLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
}


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
        wiggle()
        
    }
    
    
   
    func saveData () {
        self.performSegue(withIdentifier: "loggedin", sender: self)
    }
    
    func wiggle() {
        UIView.animate(withDuration: 2.0, animations: {
            self.logoImageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi/4) //in radians
        }) { (_) in
            UIView.animate(withDuration: 2.0
                , animations: {
                    self.logoImageView.transform = .identity
            })
        }
    }
    let userController = UserController()

    @IBOutlet weak var soupKitchenLabel: UILabel!
    @IBOutlet weak var adminPanelLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    
    
    
}


//
//  SignUpViewController.swift
//  ServeSoup
//
//  Created by Jocelyn Stuart on 2/4/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var userController: UserController?

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var roleTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    
    
    @IBAction func createAccountTapped(_ sender: UIButton) {
        guard let name = nameTextField.text, let email = emailTextField.text, let role = roleTextField.text, let password = passwordTextField.text, let confirm = confirmPasswordTextField.text else { return }
        
        if password == confirm {
            userController?.createUser(withName: name, andEmail: email, andPassword: password, andRole: role, completion: { (error) in
                if let error = error {
                    print(error)
                }
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "RegisterHome", sender: self)
                }
            })
            
        } else {
            let alert = UIAlertController(title: "Passwords do no match", message: "Please try re-entering your password!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        }
        
    }
    
}

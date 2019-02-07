//
//  SignUpViewController.swift
//  ServeSoup
//
//  Created by Jocelyn Stuart on 2/4/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        AppearanceHelper.style(button: createButton)
        view.backgroundColor = AppearanceHelper.honeydew
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        
        imageView.contentMode = .scaleAspectFit
        
        // 4
        let image = UIImage(named: "soupLogo")
        imageView.image = image
        
        
        // 5
        navigationItem.titleView = imageView
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
    
    var finalToken: String = ""
    
    @IBOutlet weak var createButton: UIButton!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var roleTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    
    
    @IBAction func createAccountTapped(_ sender: UIButton) {
        print("Sign up button tapped")
        
        // Validate required fields are not empty
        if (nameTextField.text?.isEmpty)! || (firstNameTextField.text?.isEmpty)! ||
            (emailTextField.text?.isEmpty)! ||
            (roleTextField.text?.isEmpty)! ||
            (passwordTextField.text?.isEmpty)!
        {
            // Display Alert message and return
            displayMessage(userMessage: "All fields are required to fill in")
            return
        }
        
        // Validate password
        if ((passwordTextField.text?.elementsEqual(confirmPasswordTextField.text!))! != true)
        {
            // Display alert message and return
            displayMessage(userMessage: "Please make sure that passwords match")
            return
        }
        
        //Create Activity Indicator
        let myActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        
        // Position Activity Indicator in the center of the main view
        myActivityIndicator.center = view.center
        
        // If needed, you can prevent Acivity Indicator from hiding when stopAnimating() is called
        myActivityIndicator.hidesWhenStopped = false
        
        // Start Activity Indicator
        myActivityIndicator.startAnimating()
        
        view.addSubview(myActivityIndicator)
        
        
        // Send HTTP Request to Register user
        let myUrl = URL(string: "https://soup-kitchen-backend.herokuapp.com/api/staff/register")
        // let urlJSON = myUrl!.appendingPathExtension("json")
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "POST"// Compose a query string
        request.addValue("application/json", forHTTPHeaderField: "content-type")
       // request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let postString = ["firstname": firstNameTextField.text!,
                          "lastname": nameTextField.text!,
                          "role": roleTextField.text!,
                          "email": emailTextField.text!,
                          "password": passwordTextField.text!,
                          ] as [String: String]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: postString, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            displayMessage(userMessage: "Something went wrong. Try again.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            self.removeActivityIndicator(activityIndicator: myActivityIndicator)
            
            if error != nil
            {
                self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                print("error=\(String(describing: error))")
                return
            }
            
            
            //Let's convert response sent from a server side code to a NSDictionary object:
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                if let parseJSON = json {
                    
                    
                    let token = parseJSON["token"] as? String
                    print("token: \(String(describing: token!))")
                    
                    if (token?.isEmpty)!
                    {
                        // Display an Alert dialog with a friendly error message
                        self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                        return
                    } else {
                        self.displayMessage(userMessage: "Successfully Registered a New Account. Please proceed to Sign in")
                    }
                    
                } else {
                    //Display an Alert dialog with a friendly error message
                    self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                }
            } catch {
                
                self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                
                // Display an Alert dialog with a friendly error message
                self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                print(error)
            }
        }
        
        task.resume()
        
    }
    
    
    
    func removeActivityIndicator(activityIndicator: UIActivityIndicatorView)
    {
        DispatchQueue.main.async
            {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
        }
    }
    
    
    func displayMessage(userMessage:String) -> Void {
        DispatchQueue.main.async
            {
                let alertController = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                    // Code in this block will trigger when OK button tapped.
                    print("Ok button tapped")
                    DispatchQueue.main.async
                        {
                            self.dismiss(animated: true, completion: nil)
                    }
                }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion:nil)
        }
    }
    
    func setupAppearance() {
        
    }
    
}

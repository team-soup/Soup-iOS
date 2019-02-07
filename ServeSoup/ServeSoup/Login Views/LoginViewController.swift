//
//  LoginViewController.swift
//  ServeSoup
//
//  Created by Jocelyn Stuart on 2/4/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppearanceHelper.honeydew
        AppearanceHelper.style(button: loginButton)
        label.textColor = AppearanceHelper.queenBlue
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
        // navigationItem.titleView?.addSubview(imageView)
    }
    
    var userController: UserController?
    var user: User?
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        print("Sign in button tapped")
        
        // Read values from text fields
        let email = emailTextField.text
        let password = passwordTextField.text
        
        // Check if required fields are not empty
        if (email?.isEmpty)! || (password?.isEmpty)!
        {
            // Display alert message here
            print("Email \(String(describing: email)) or password \(String(describing: password)) is empty")
            displayMessage(userMessage: "One of the required fields is missing")
            
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
        
        
        //Send HTTP Request to perform Sign in
        let myUrl = URL(string: "https://soup-kitchen-backend.herokuapp.com/api/staff/login")
        var request = URLRequest(url:myUrl!)
        
        request.httpMethod = "POST"// Compose a query string
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        //request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let postString = ["email": email!, "password": password!] as [String: String]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: postString, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            displayMessage(userMessage: "Something went wrong...")
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
                    
                    if parseJSON["errorMessageKey"] != nil
                    {
                        self.displayMessage(userMessage: parseJSON["errorMessage"] as! String)
                        return
                    }
                    // Now we can access value of First Name by its key
                    let accessToken = parseJSON["token"] as? String
                    // let userId = parseJSON["id"] as? String
                    print("Access token: \(String(describing: accessToken!))")
                    
                    let saveAccesssToken: Bool = KeychainWrapper.standard.set(accessToken!, forKey: "accessToken")
                   // self.userController?.finalToken = accessToken!
                    // let saveUserId: Bool = KeychainWrapper.standard.set(userId!, forKey: "userId")
                    
                    print("The access token save result: \(saveAccesssToken)")
                    //  print("The userId save result \(saveUserId)")
                    
                    if (accessToken?.isEmpty)!
                    {
                        // Display an Alert dialog with a friendly error message
                        self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                        return
                    }
                    
                    DispatchQueue.main.async
                        {
                          /*  let homePage = self.storyboard?.instantiateViewController(withIdentifier: "InventoryTableView") as! InventoryTableViewController
                            let appDelegate = UIApplication.shared.delegate
                            appDelegate?.window??.rootViewController = homePage */
                            self.performSegue(withIdentifier: "LogintoCollection", sender: self)
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
    
    func removeActivityIndicator(activityIndicator: UIActivityIndicatorView)
    {
        DispatchQueue.main.async
            {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
        }
    }
    
    
    
}
    



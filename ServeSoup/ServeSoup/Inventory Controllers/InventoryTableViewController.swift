//
//  InventoryTableViewController.swift
//  ServeSoup
//
//  Created by Jocelyn Stuart on 2/4/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class InventoryTableViewController: UITableViewController {
    
    let itemController = ItemController()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadMemberProfile()
       /* itemController.fetchItems { (error) in
            if let error = error {
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }*/
    }


    // MARK: - Table view data source

  /*  override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    } */

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemController.items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemTableViewCell

        let item = itemController.items[indexPath.row]
        cell.item = item

        return cell
    }
    

  
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete else { return }
        
        // Implement here
        let item = itemController.items[indexPath.row]
        itemController.delete(item: item) { (error) in
            if let error = error {
                print(error)
            }
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        }
    }
    
    // MARK: - Navigation

    //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ItemDetail" {
            guard let cellDetailController = segue.destination as? ItemDetailViewController, let cell = sender as? ItemTableViewCell else { return }
            
            cellDetailController.itemController = itemController
            cellDetailController.item = cell.item
            
        } else if segue.identifier == "AddItem" {
            guard let addItemController = segue.destination as? ItemDetailViewController else { return }
            
            addItemController.itemController = itemController
            
        }
        
    }
    
    func loadMemberProfile() {
        let accessToken: String = KeychainWrapper.standard.string(forKey: "accessToken")!
      //  let userId: String? = KeychainWrapper.standard.string(forKey: "userId")
        print(accessToken)
        let myUrl = URL(string: "https://soup-kitchen-backend.herokuapp.com/api/items")
        var request = URLRequest(url: myUrl!)
        request.httpMethod = "GET"// Compose a query string
        request.addValue("\(String(describing: accessToken))", forHTTPHeaderField: "Authorization")
       // print(request) //Bearer
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                print("error=\(String(describing: error))")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                if let parseJSON = json {
                    
                    DispatchQueue.main.async
                        {
                            self.itemController.items = (parseJSON["items"] as? Array)!
                          /*  let firstName: String?  = parseJSON["firstName"] as? String
                            let lastName: String? = parseJSON["lastName"] as? String
                            
                            if firstName?.isEmpty != true && lastName?.isEmpty != true {
                                self.userFullNameLabel.text =  firstName! + " " + lastName!
                            }*/
                    }
                } else {
                    //Display an Alert dialog with a friendly error message
                    self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                }
                
            } catch {
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
                }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion:nil)
        }
    }
    
    
    
    
    
}
    
    
    
    


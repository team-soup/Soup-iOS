//
//  InventoryCollectionViewController.swift
//  ServeSoup
//
//  Created by Jocelyn Stuart on 2/5/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper



class InventoryCollectionViewController: UICollectionViewController {

    let itemController = ItemController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Register cell classes
      //  self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ItemCell")

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadMemberProfile()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated:true);
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        
        imageView.contentMode = .scaleAspectFit
        
        // 4
        let image = UIImage(named: "soupLogo")
        imageView.image = image
        
        
        // 5
        //navigationItem.titleView = imageView
       // navigationItem.titleView?.addSubview(imageView)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ItemDetail" {
            guard let cellDetailController = segue.destination as? CollectionDetailViewController, let cell = sender as? ItemCollectionViewCell else { return }
            
            cellDetailController.itemController = itemController
            cellDetailController.item = cell.item
            
        } else if segue.identifier == "AddItem" {
            guard let addItemController = segue.destination as? CollectionDetailViewController else { return }
            
            addItemController.itemController = itemController
            
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return itemController.items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemCollectionViewCell
    
        let item = itemController.items[indexPath.row]
        cell.item = item
    
        return cell
    }

   

   /* override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        
        let item = itemController.items[indexPath.row]
        itemController.delete(item: item) { (error) in
            if let error = error {
                print(error)
            }
            DispatchQueue.main.async {
                collectionView.reloadData()
            }
        }
    }*/
 
  
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
            guard let data = data else {
                NSLog("error")
                return
            }
            do {
                // let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                let json = try JSONDecoder().decode(UpperLevel.self, from: data)
                
                self.itemController.items = json.items
                
                
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



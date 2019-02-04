//
//  InventoryTableViewController.swift
//  ServeSoup
//
//  Created by Jocelyn Stuart on 2/4/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class InventoryTableViewController: UITableViewController {
    
    let itemController = ItemController()

    override func viewDidLoad() {
        super.viewDidLoad()

       
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
}
    
    
    
    


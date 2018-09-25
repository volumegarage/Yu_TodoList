//
//  ViewController.swift
//  Yu_Todoey
//
//  Created by David Cate on 9/24/18.
//  Copyright © 2018 David Cate. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    // Step 1
    // Create Item Array
    
    var itemArray = ["Complete Horizon Report", "Call Horizon", "Let Camera People know", "Email Martive", "Develop Horizon Flexible Campaign"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // Step 2 - Create the Table View Data Source Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create a reuseable cell
        // Identifier we gave to item cell
        // for: current indexPath the tableview is looking to populate
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    // In order to print and configure which table is selected, we need a tableView Delegate Method
    //MARK - TABLEVIEW DELEGATE METHODS
    
    // Fired when we click on a table in a cell row.
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // print(indexPath.row) // Printing row
        // print(itemArray[indexPath.row])
        
  
        
        // How to remove from cell if there is a checkmark
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }   else {
                    // Give the cell a checkmark as selected.
                    tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark

        }
        
        // Removes selected highlight when clicked.
        tableView.deselectRow(at: indexPath, animated: true)
        

    }
    
    
    //MARK - Add New Items
    
    // Adding Add Item Buttom with IBAction from TableView Controller
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
 
    // Setup textfield variable to handle text from textfield below.
        
        var textField = UITextField() // Local variable to store
        
    // Show PopUp
    // Have UI Text Field to Add Item
    // And Append it To Item Array
    
    let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
    
    let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
        // what happens when the user clicks the add item button
//        print(textField.text!)
        
        // Append item our item Array
        self.itemArray.append(textField.text!) // Use SELF because I'm inside a closure.
        
        self.tableView.reloadData() // Reloads the table in tableview
        
        // First - change itemArray to be immutable
    }
        
        // Add text field to pop-up
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"            
            textField = alertTextField
        }
    
    alert.addAction(action)
    
    present(alert, animated: true, completion: nil)

        }

   }

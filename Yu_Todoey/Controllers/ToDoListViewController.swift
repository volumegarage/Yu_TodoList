//
//  ViewController.swift
//  Yu_Todoey
//
//  Created by David Cate on 9/24/18.
//  Copyright © 2018 David Cate. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {

    // Step 1
    // Create Item Array
    
//    var itemArray = ["Complete Horizon Report", "Call Horizon", "Let Camera People know", "Email Martive", "Develop Horizon Flexible Campaign"] - First Look before persitent data
    
    var itemArray = [Item]()
    
    // In order to store data, we need to setup variable for User Defaults
    
//    let defaults = UserDefaults.standard // Eliminated from code after establishing dataFilePath for storage and creating our own plist file
    
    // User defaults are saved in plist file
    // Saved in key value pairs
    
    // Create a File Path to the Document folder
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    //        let newItem = Item() // Changed for Core Data Implementation.
    //  Made Global for use in two methods below.
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        
        print(dataFilePath)
        
//        let newItem = Item()
//        newItem.title = "Find Mike"
//        itemArray.append(newItem)
//        
//        let newItem2 = Item()
//        newItem2.title = "Buy Eggos"
//        itemArray.append(newItem2)
//        
//        let newItem3 = Item()
//        newItem3.title = "Destroy Demogorgon"
//        itemArray.append(newItem3)
        
//         Set itemArray to use User Defaults from .plist
//        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
//            itemArray = items
//        }
        
        // Info above was called directly. Now we need to load items from P.list and persistent storage
//        loadItems() // Method we create down below - REMOVED FOR USE WITH CORE DATA
        
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
        
        
        
        
        let item = itemArray[indexPath.row] // REFACTORING FROM BELOW
        
//        cell.textLabel?.text = itemArray[indexPath.row] - This old returns an item object. We need to get title property using dot notion
//        cell.textLabel?.text = itemArray[indexPath.row].title
        cell.textLabel?.text = item.title // REFACTORED FROM ABOVE
        
        // Setting new accessory type with data model
//        if itemArray[indexPath.row].done == true { // REFACTORED FROM BELOW WITH ITEM
  
//        if item.done == true {
//
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        // SHORTEN THESE ITEMS ABOVE USING A TERNERARY OPERATOR
        // TERNARY OPERATOR ==>
        // value = condition ? valueifTrue : valueifFalse
        
        cell.accessoryType = item.done ? .checkmark : .none // One line expression - composed of three parts.
        
        return cell
    }
    
    // In order to print and configure which table is selected, we need a tableView Delegate Method
    //MARK - TABLEVIEW DELEGATE METHODS
    
    // Fired when we click on a table in a cell row.
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // print(indexPath.row) // Printing row
        // print(itemArray[indexPath.row])
        
  
        
        
        
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
        
        // REFACTOR FROM ABOVE
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done // Sets to opposits
        // Booleans only have one or two states
        
        
        // USE SAVEITEM METHOD TO SAVE CHECKLIST TO PLIST
        saveItems()
        
        
        // How to remove from cell if there is a checkmark [ REMOVED FOR NEW DATA MDEL ABOVE ]
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }   else {
//                    // Give the cell a checkmark as selected.
//                    tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//
//        }
        
//        tableView.reloadData() - Eliminated because of using saved items above.
        
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
        // self.itemArray.append(textField.text!) // Use SELF because I'm inside a closure.
        
        
        
//        let newItem = Item() // Changed for Core Data Implementation.
        
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext // Eliminated when this line was made Global above.
//        let newItem = Item(context: context) // Eliminated when this line was made Global above.
//
        let newItem = Item(context: self.context) // Because we are in closure
        
        
        
        
        newItem.title = textField.text! // New Data model that uses new item to attach title to text field property.
        
        // WITH CORE DATA, WE HAVE TO SET DEFAULT STATE OF DONE TO FALSE
        newItem.done = false
        
//        self.itemArray.appen(textField.text!)
        self.itemArray.append(newItem) // For new data model.
        
        // We can now save this new item array to our User Defaults as outlined above
//        self.defaults.set(self.itemArray, forKey: "ToDoListArray") - ELIMINATED TO ASSIGN PLIST AND DOCUMENT PATH
        // ESTABLISHED NEW ENCODER
        
        
        // THEN MOVED TO SAVEITEM METHOD BELOW
//        let encoder = PropertyListEncoder()
//
//        do {
//        let data = try encoder.encode(self.itemArray)
//            try data.write(to: self.dataFilePath!)
//        } catch {
//            print("Error encoding item array \(error)")
//        }
//
//        self.tableView.reloadData() // Reloads the table in tableview
        
        // First - change itemArray to be immutable
        
        self.saveItems()
    }
        
        // Add text field to pop-up
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
    
    alert.addAction(action)
    
    present(alert, animated: true, completion: nil)

        }
    
    //MARK - Model Manipulation Methods
    
    func saveItems() {
        
//        let encoder = PropertyListEncoder() - Eliminated for Core Data
        
        do {
//            let data = try encoder.encode(itemArray) - Eliminated for Core Data
//            try data.write(to: dataFilePath!) - Eliminated for Core Data
            
            // Use new Save Context Method from CoreData element in App Delegate
           try context.save()
            
        } catch {
          print("Error encoding item array \(error)")
        }
        
        self.tableView.reloadData() // Reloads the table in tableview
        
    }
    
//    func loadItems() { // DELETED FOR USE OF CORE DATA
//
//        if let data = try? Data(contentsOf: dataFilePath!) {
//            let decoder = PropertyListDecoder()
//
//            do {
//                itemArray = try decoder.decode([Item].self, from: data)
//            } catch {
//                print("Error decoding item \(error)")
//            }
//        }
//    }

   }

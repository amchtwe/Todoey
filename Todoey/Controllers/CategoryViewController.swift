//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Aung Mon Chit Htwe on 8/4/18.
//  Copyright © 2018 AMCH. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    var categories : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoadCategories()
        
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added Yet"
        return cell
        
    }
    
    //MARK: - Data Manipulation Methods
    
    func LoadCategories() {
        
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
 
    func Save(category : Category){
        do{
            try realm.write {
                realm.add(category)
            }
        }catch{
            print("Error on SaveCategories \(error)")
        }
        tableView.reloadData()
    }
    
    //MARK: - Add New Categories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "New Category", style: .default) { (abc) in
            // the following code will execute once user click add button on alert 
            
            let newCategory = Category()
            newCategory.name = textField.text!
            self.Save(category: newCategory)

        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Please enter new category name"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }

    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            
            destinationVC.selectedCategory = categories?[indexPath.row]
            
        }
        
    }
    
    
    
}

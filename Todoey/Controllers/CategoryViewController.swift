//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Aung Mon Chit Htwe on 8/4/18.
//  Copyright © 2018 AMCH. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var catArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoadCategories()
        
        //context.delete(catArray[0])
        //context.delete(catArray[1])
        //context.delete(catArray[2])
        
        //SaveCategories()
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = catArray[indexPath.row].name
        
        return cell
        
    }
    
    //MARK: - Data Manipulation Methods
    
    func LoadCategories() {
        do{
            let request : NSFetchRequest<Category> = Category.fetchRequest()
            try catArray = context.fetch(request)
        } catch{
            print("Error on LoadCategories \(error)")
        }
        tableView.reloadData()
    }
 
    func SaveCategories(){
        do{
            try context.save()
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
            
            let newCategory = Category(context: self.context)
            
            newCategory.name = textField.text!
            
            self.catArray.append(newCategory)
            
            self.SaveCategories()

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
            
            destinationVC.selectedCategory = catArray[indexPath.row]
            
        }
        
    }
    
    
    
}

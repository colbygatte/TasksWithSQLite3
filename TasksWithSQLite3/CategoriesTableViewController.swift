//
//  CategoriesTableViewController.swift
//  TasksWithSQLite3
//
//  Created by Colby Gatte on 11/14/16.
//  Copyright © 2016 colbyg. All rights reserved.
//

import UIKit
import FMDB

class CategoriesTableViewController: UITableViewController, AddNewCategoryViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        //App.appSetup()
        
        App.categories = Database.selectAllCategories()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addNewCategoryViewControllerDelegateDidAddCategory() {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return App.categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = App.categories[indexPath.row].title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let categoryid = App.categories[indexPath.row].categoryid
            App.categories[indexPath.row].delete()
            App.categories.remove(at: indexPath.row)
            
            // delete the tasks associated with it
            Task.deleteTasksBelongingTo(categoryid: categoryid!)
            
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ViewTasksInACategory" {
            let tasksTableViewController = segue.destination as! TasksTableViewController
            tasksTableViewController.categoryid = App.categories[(tableView.indexPathForSelectedRow?.row)!].categoryid
        } else if segue.identifier == "AddNewCategory" {
            let addNewCategoryViewController = segue.destination as! AddNewCategoryViewController
            addNewCategoryViewController.delegate = self
        }
    }
    
}

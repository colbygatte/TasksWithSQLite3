//
//  TasksTableViewController.swift
//  TasksWithSQLite3
//
//  Created by Colby Gatte on 11/14/16.
//  Copyright © 2016 colbyg. All rights reserved.
//

import UIKit
import FMDB
import BEMCheckBox

class TasksTableViewController: UITableViewController {

    var categoryid: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "TaskTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "TaskCell")
        
        print(self.categoryid)
        App.tasks[categoryid] = [Task]()
        App.tasks[categoryid] = Database.selectAllTasks(inCategory: categoryid)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (App.tasks[categoryid]?.count)!
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskTableViewCell
        
        cell.task = App.tasks[categoryid]?[indexPath.row]
        if cell.task.status == 1 {
            cell.checkboxView.on = true
        }
        
        cell.taskLabel.text = App.tasks[categoryid]?[indexPath.row].task
        cell.delegate = self

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            App.tasks[categoryid]![indexPath.row].delete()
            App.tasks[categoryid]!.remove(at: indexPath.row)
        }
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddNewTaskToCategory" {
            let addNewTaskToCategoryViewController = segue.destination as! AddNewTaskToCategoryViewController
            addNewTaskToCategoryViewController.categoryid = self.categoryid
            addNewTaskToCategoryViewController.delegate = self
        }
    }

}

// @@@@ might not need this
extension TasksTableViewController: TaskTableViewCellDelegate {
    func taskTableViewCellDelegate(checkedTaskId: Int) {
        
    }
    
    func tasktableViewCellDelegate(uncheckedTaskId: Int) {
        
    }
}

extension TasksTableViewController: AddNewTaskToCategoryViewControllerDelegate {
    func addNewTaskToCategoryDelegateDidAddTask() {
        self.tableView.reloadData()
    }
}


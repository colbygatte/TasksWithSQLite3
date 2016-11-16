//
//  AddNewTaskToCategoryViewController.swift
//  TasksWithSQLite3
//
//  Created by Colby Gatte on 11/14/16.
//  Copyright © 2016 colbyg. All rights reserved.
//

import UIKit

protocol AddNewTaskToCategoryViewControllerDelegate {
    func addNewTaskToCategoryDelegateDidAddTask()
}

class AddNewTaskToCategoryViewController: UITableViewController {
    var categoryid: Int!
    var delegate: AddNewTaskToCategoryViewControllerDelegate!
    
    @IBOutlet var taskTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addTaskButtonPressed() {
        App.tasks[categoryid]?.append(
            Task(createNewTask: self.taskTextField.text!, categoryid: categoryid)
        )
        
        delegate.addNewTaskToCategoryDelegateDidAddTask()
        
        _ = self.navigationController?.popViewController(animated: true)
    }

}

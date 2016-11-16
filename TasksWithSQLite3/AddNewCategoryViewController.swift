//
//  AddNewCategoryViewController.swift
//  TasksWithSQLite3
//
//  Created by Colby Gatte on 11/14/16.
//  Copyright © 2016 colbyg. All rights reserved.
//

import UIKit

protocol AddNewCategoryViewControllerDelegate {
    func addNewCategoryViewControllerDelegateDidAddCategory()
}

class AddNewCategoryViewController: UITableViewController {
    var delegate: AddNewCategoryViewControllerDelegate!
    
    @IBOutlet var categoryTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addCategoryButtonPressed() {
        App.categories.append(
            Category(createNewCategory: self.categoryTextField.text!)
        )
        
        delegate.addNewCategoryViewControllerDelegateDidAddCategory()
        
        _ = self.navigationController?.popViewController(animated: true)
    }

}

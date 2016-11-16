//
//  Category.swift
//  TasksWithSQLite3
//
//  Created by Colby Gatte on 11/14/16.
//  Copyright © 2016 colbyg. All rights reserved.
//

import UIKit

extension DBQueries {
    // Categories
    static var selectAllCategories = "SELECT * FROM categories;"
    
    static var insertIntoCategories = "INSERT INTO categories (title) VALUES (?);"
    
    static var removeTasksByCategoryId = "DELETE FROM tasks WHERE belongsToCategory = ?"
    static var removeCategoryByCategoryId = "DELETE FROM categories WHERE categoryid = ?"
    
}

extension Database {
    static func selectAllCategories() -> [Category] {
        
        var categories: [Category] = []
        
        do {
            let results = try App.db.executeQuery(DBQueries.selectAllCategories, values: nil)
            while results.next() {
                
                let category = Category(initWith: results.resultDictionary() as! [String:Any?])
                categories.append(category)
            }
            
            return categories
        } catch {
            print(App.db.lastError().localizedDescription)
            return categories
        }
    }
    
    // Returns the categoryid of the inserted category
    static func insertIntoCategories(title: String) -> Int {
        App.db.executeUpdate(DBQueries.insertIntoCategories, withArgumentsIn: [title])
        return Int(App.db.lastInsertRowId())
    }
    
    static func removeTasksBy(categoryid: Int) {
        App.db.executeUpdate(DBQueries.removeTasksByCategoryId, withArgumentsIn: [categoryid])
    }
    
    static func removeCategoryBy(categoryid: Int) {
        App.db.executeUpdate(DBQueries.removeCategoryByCategoryId, withArgumentsIn: [categoryid])
    }
}

class Category: NSObject {
    var title: String!
    var categoryid: Int!
    

    init(initWith object: [String:Any?]) {
        super.init()

        self.title = object["title"] as! String
        self.categoryid = object["categoryid"] as! Int
    }
    
    // need to get the new id
    init(createNewCategory: String) {
        self.categoryid = Database.insertIntoCategories(title: createNewCategory)
        self.title = createNewCategory
    }
    
    func delete() {
        Database.removeTasksBy(categoryid: self.categoryid)
        Database.removeCategoryBy(categoryid: self.categoryid)
    }
    
}







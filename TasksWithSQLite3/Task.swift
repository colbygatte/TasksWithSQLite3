//
//  Task.swift
//  TasksWithSQLite3
//
//  Created by Colby Gatte on 11/14/16.
//  Copyright © 2016 colbyg. All rights reserved.
//

import UIKit

extension DBQueries {
    // Tasks
    static var selectAllTasksCategory = "SELECT * FROM tasks WHERE belongsToCategory = ?;"
    
    static var insertIntoTasks = "INSERT INTO tasks (belongsToCategory, task, status, createdAt) VALUES (?, ?, ?, ?);"
    
    static var deleteTaskWithTaskId = "DELETE FROM tasks WHERE taskid = ?;"
    
    static var updateTaskStatusWithTaskId = "UPDATE tasks SET status = ? WHERE taskid = ?"
}

extension Database {
    static func selectAllTasks(inCategory categoryId: Int) -> [Task] {
        var tasks = [Task]()
        
        do {
            let results = try App.db.executeQuery(DBQueries.selectAllTasksCategory, values: [categoryId])
            
            while (results.next()) {
                tasks.append(Task(initWith: results.resultDictionary() as! [String:Any?]))
            }
            
            return tasks
        } catch {
            return tasks
        }
    }
    
    static func insertIntoTasks(belongsToCategory: Int, task: String, createdAt: String) -> Int { // returns taskid
        App.db.executeUpdate(DBQueries.insertIntoTasks, withArgumentsIn: [belongsToCategory, task, 0, createdAt])
        return Int(App.db.lastInsertRowId())
    }
    
    static func deleteTaskWith(taskid: Int) {
        App.db.executeUpdate(DBQueries.deleteTaskWithTaskId, withArgumentsIn: [taskid])
    }
    
    static func updateTaskStatus(status: Int, taskid: Int) {
        do {
            try App.db.executeUpdate(DBQueries.updateTaskStatusWithTaskId, values: [status, taskid])
        } catch {
            print(App.db.lastError().localizedDescription)
        }
        
    }
    
}

class Task: NSObject {
    var taskid: Int!
    var belongsToCategory: Int!
    var status: Int!
    var createdAt: String!
    var task: String!
    
    static func deleteTasksBelongingTo(categoryid: Int) {
        
    }
    
    init(initWith object: [String:Any?] ) {
        super.init()
        
        taskid = object["taskid"] as! Int
        belongsToCategory = object["belongsToCategory"] as! Int
        status = object["status"] as! Int
        createdAt = object["createdAt"] as! String
        task = object["task"] as! String
    }
    
    
    init(createNewTask: String, categoryid: Int) {
        super.init()
        
        createdAt = App.dateTime.string(from: Date())
        taskid = Database.insertIntoTasks(belongsToCategory: categoryid, task: createNewTask, createdAt: self.createdAt)
        status = 0
        task = createNewTask
        belongsToCategory = categoryid
    }
    
    func toggleStatus() {
        if status == 0 {
            status = 1
        } else {
            status = 0
        }
        
        Database.updateTaskStatus(status: status, taskid: taskid)
    }
    
    func delete() {
        Database.deleteTaskWith(taskid: self.taskid)
    }
}





















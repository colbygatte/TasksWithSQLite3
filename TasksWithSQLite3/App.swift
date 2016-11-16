//
//  App.swift
//  TasksWithSQLite3
//
//  Created by Colby Gatte on 11/14/16.
//  Copyright © 2016 colbyg. All rights reserved.
//

// global data stored here

import UIKit
import FMDB

class App: NSObject {
    static var categories: [Category]!
    static var tasks: [Int:[Task]]! = [:] // [categoryname:[Task]]
    
    static var dateTime = DateFormatter()
    
    static var db: FMDatabase!
    
    static func appFirstTimeSetup() {
        App.db.executeStatements(DBQueries.initialSQL)
    }

    static func appSetup() {
        App.dateTime.dateFormat = "yyyy-MM-dd HH:mm:ss"
    }
}

//
//  Database.swift
//  TasksWithSQLite3
//
//  Created by Colby Gatte on 11/14/16.
//  Copyright © 2016 colbyg. All rights reserved.
//

import UIKit
import FMDB

// CREATE TABLE tasks(  taskid INTEGER PRIMARY KEY AUTOINCREMENT,  belongsToCategory INTEGER,  task TEXT,  status INT,   createdAt DATETIME);

struct DBQueries {
    static var initialSQL = "PRAGMA foreign_keys=OFF;BEGIN TRANSACTION;CREATE TABLE categories(  categoryid INTEGER PRIMARY KEY AUTOINCREMENT,  title VARCHAR(25));INSERT INTO 'categories' VALUES(1,'Home');INSERT INTO 'categories' VALUES(2,'Work');CREATE TABLE tasks(  taskid INTEGER PRIMARY KEY AUTOINCREMENT,  belongsToCategory INTEGER,  task TEXT,  status INT,   createdAt DATETIME);INSERT INTO 'tasks' VALUES(1,1,'Cook supper',1,'2016-11-15 03:14:35');INSERT INTO 'tasks' VALUES(2,1,'Vacuum the floor',0,'2016-11-15 03:14:35');INSERT INTO 'tasks' VALUES(3,2,'Complete Project X',0,'');INSERT INTO 'tasks' VALUES(4,2,'Buy more pens',1,'');DELETE FROM sqlite_sequence;INSERT INTO 'sqlite_sequence' VALUES('categories',2);INSERT INTO 'sqlite_sequence' VALUES('tasks',4);COMMIT;"
    
}

class Database: NSObject {
    // Queries: after each underscore is the parameter expected
}

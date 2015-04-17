//
//  TodoManager.swift
//  ToDoDo
//
//  Created by 熱海大介 on 2015/03/11.
//  Copyright (c) 2015年 com.datsnet. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class TodoManager {
    // Singleton
    static var sharedInstance = TodoManager()
    
    func insertTodoCategory(data: String) -> Bool {
        // managedObjectContext取得
        var appDelegate : AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context : NSManagedObjectContext = appDelegate.managedObjectContext!
        
        // 新しいオブジェクトを作成
        var newCategory = NSEntityDescription.insertNewObjectForEntityForName(
            "Category", inManagedObjectContext: context) as! NSManagedObject
        newCategory.setValue(data, forKey: "name")
        
        // 作成したオブジェクトを保存
        var error: NSError? = nil
        if !context.save(&error) {
            return false
        }
        
        println(newCategory)
        println("New Object Saved!")
        return true
    }
    
    func insertTodoItem(data: String) -> Bool {
        // managedObjectContext取得
        var appDelegate : AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context : NSManagedObjectContext = appDelegate.managedObjectContext!
        
        let entity = NSEntityDescription.entityForName("Todo", inManagedObjectContext: context)
        let todo = Todo(entity: entity!, insertIntoManagedObjectContext: context)
        
//        todo.name = data
//        todo.complete = 0

        todo.setValue(data, forKey: "name")
        todo.setValue(0, forKey: "complete")
        
        
        // オブジェクトを保存
        var error: NSError? = nil
        if !context.save(&error) {
            return false
        }
        
        println(data)
        println("New Object Saved!")
        return true

    }
    
    
}

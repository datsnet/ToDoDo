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

public class TodoCoreDataManager {
    // Singleton
    public static var sharedInstance = TodoCoreDataManager()
    
    public func insertTodoCategory(data: String) -> Bool {
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
    
    public func insertTodoCategoryItem(data: String) -> (Bool, AnyObject?) {
        // managedObjectContext取得
        var appDelegate : AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context : NSManagedObjectContext = appDelegate.managedObjectContext!
        
        let entity = NSEntityDescription.entityForName("Category", inManagedObjectContext: context)
        let category = Category(entity: entity!, insertIntoManagedObjectContext: context)
        
        category.setValue(data, forKey: "name")
        
        // オブジェクトを保存
        var error: NSError? = nil
        if !context.save(&error) {
            return (false, nil)
        }
        
        println(data)
        println("New Object Saved!")
        return (true, category)
    }
    
    public func updateTodoCategoryItem(obj: AnyObject?) -> Bool {
        // managedObjectContext取得
        var appDelegate : AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context : NSManagedObjectContext = appDelegate.managedObjectContext!
        
        // オブジェクトを保存
        var error: NSError? = nil
        if !context.save(&error) {
            return false
        }
        
        println("New Object Saved!")
        return true
    }
    
    public func deleteTodoCategoryItem(obj: AnyObject?) -> Bool {
        // managedObjectContext取得
        var appDelegate : AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context : NSManagedObjectContext = appDelegate.managedObjectContext!
        if let category = obj as? Category {
            context.deleteObject(category)
        } else {
            return false
        }
        // オブジェクトを保存
        var error: NSError? = nil
        if !context.save(&error) {
            return false
        }
        
        println("New Object Saved!")
        return true
    }
    
    
    public func insertTodoItem(data: String) -> Bool {
        // managedObjectContext取得
        var appDelegate : AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context : NSManagedObjectContext = appDelegate.managedObjectContext!
        
        let entity = NSEntityDescription.entityForName("Todo", inManagedObjectContext: context)
        let todo = Todo(entity: entity!, insertIntoManagedObjectContext: context)

        todo.name = data;
        todo.complete = 0
        
        // オブジェクトを保存
        var error: NSError? = nil
        if !context.save(&error) {
            return false
        }
        
        println(data)
        println("New Object Saved!")
        return true

    }
    
    public func insertTodoItem(data: String, Category obj: AnyObject?) -> Bool {
        // managedObjectContext取得
        var appDelegate : AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context : NSManagedObjectContext = appDelegate.managedObjectContext!
        
        let entity = NSEntityDescription.entityForName("Todo", inManagedObjectContext: context)
        let todo = Todo(entity: entity!, insertIntoManagedObjectContext: context)
        let category = obj as! Category
        todo.name = data;
        todo.complete = 0
        todo.category = category
        
        
        // オブジェクトを保存
        var error: NSError? = nil
        if !context.save(&error) {
            return false
        }
        
        println(data)
        println("New Object Saved!")
        return true
        
    }
    
    public func selectAllTodoItem() -> [AnyObject]? {
        var appDelegate : AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context : NSManagedObjectContext = appDelegate.managedObjectContext!

        let fetchRequest = NSFetchRequest(entityName: "Todo")
        let sortDescriptor = NSSortDescriptor(key: "sort", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        return fetchData(fetchRequest, managedObjectContext: context)
    }
    
    public func selectAllTodoCategoryItem() -> [AnyObject]? {
        var appDelegate : AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context : NSManagedObjectContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName: "Category")
        let sortDescriptor = NSSortDescriptor(key: "sort", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        return fetchData(fetchRequest, managedObjectContext: context)
    }
    
    public func selectTodoItemByCategory(Category obj: AnyObject) -> [AnyObject]? {
        var appDelegate : AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context : NSManagedObjectContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName: "Todo")
        let targetCategory = obj as! Category
//        fetchRequest.predicate = NSPredicate(format: "%K = %d", "category_id", id)
        let sortDescriptor = NSSortDescriptor(key: "sort", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let todos: [AnyObject]! = fetchData(fetchRequest, managedObjectContext: context)
        let results = NSMutableArray()
        for var i = 0; i < todos!.count; i++ {
            if let category = (todos[i] as? Todo)?.category {
                if (targetCategory.isEqual(category)) {
//                    return todos[i] as! Todo
                    results.addObject(todos[i])
                }
            }
        }
        return results as [AnyObject]
    }
    
    public func fetchData(fetchRequest: NSFetchRequest, managedObjectContext context: NSManagedObjectContext) -> [AnyObject]? {
        var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        var error: NSError?
        var results = context.executeFetchRequest(fetchRequest, error: &error)
        if ((error) != nil) {
            println(error)
        }
        return results!
    }
    
    
}

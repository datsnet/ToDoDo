//
//  CoreDataManager.swift
//  ToDoDo
//
//  Created by 熱海大介 on 2015/04/16.
//  Copyright (c) 2015年 com.datsnet. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager: NSObject {
    
    override init(){
        super.init()
        
        // all CoreDataHelper share one CoreDataStore defined in AppDelegate
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "contextDidSaveContext:", name: NSManagedObjectContextDidSaveNotification, object: nil)
    }
    
    static func fetchManagedObjectContext() -> NSManagedObjectContext? {
        let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let managedObjectContext = appDelegate.managedObjectContext
        return managedObjectContext
    }
    
    static func saveContext (context: NSManagedObjectContext) {
        var error: NSError? = nil
        if context.hasChanges && !context.save(&error) {
            
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        }
    }
    
    
//    static func fetchData(fetchRequest: NSFetchRequest) -> NSFetchedResultsController? {
      static func fetchData(fetchRequest: NSFetchRequest) -> NSArray? {
        let managedObjectContext = fetchManagedObjectContext()
        var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        var error: NSError?
        var results = managedObjectContext!.executeFetchRequest(fetchRequest, error: &error)
        if ((error) != nil) {
            println(error)
        }
//        return fetchedResultController
        return results
    }
    
    static func insertData(_entity entity: NSEntityDescription) {
        let managedObjectContext = fetchManagedObjectContext()
        saveContext(managedObjectContext!)
    }
}
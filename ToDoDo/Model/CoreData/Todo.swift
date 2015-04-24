//
//  Todo.swift
//  
//
//  Created by 熱海大介 on 2015/04/24.
//
//

import Foundation
import CoreData

class Todo: NSManagedObject {

    @NSManaged var complete: NSNumber
    @NSManaged var favorite: NSNumber
    @NSManaged var limitedDate: NSDate
    @NSManaged var name: String
    @NSManaged var note: String
    @NSManaged var reminderDate: NSDate
    @NSManaged var sort: NSNumber
    @NSManaged var tags: NSSet
    @NSManaged var category: Category

}

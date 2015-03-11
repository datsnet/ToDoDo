//
//  Todo.swift
//  ToDoDo
//
//  Created by 熱海大介 on 2015/03/11.
//  Copyright (c) 2015年 com.datsnet. All rights reserved.
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
    @NSManaged var tag: NSSet

}

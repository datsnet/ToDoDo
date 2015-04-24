//
//  Category.swift
//  
//
//  Created by 熱海大介 on 2015/04/24.
//
//

import Foundation
import CoreData

class Category: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var sort: NSNumber
    @NSManaged var todos: NSSet

}

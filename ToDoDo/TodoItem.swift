//
//  TodoItem.swift
//  ToDoDo
//
//  Created by 熱海 大介 on 2015/02/17.
//  Copyright (c) 2015年 com.datsnet. All rights reserved.
//

import Foundation

class TodoItem: NSObject {
    var isChecked: Bool! = false
    var todoTitle: NSString!

    convenience init(isChecked: Bool, todoTitle: NSString) {
        self.init()
        self.isChecked = isChecked
        self.todoTitle = todoTitle
    }
    func getTodoTitle() -> NSString {
        return todoTitle!
    }
    func setTodoTitle(todoTitle: NSString) {
        self.todoTitle = todoTitle
    }
    func setIsChecked(isChecked: Bool) {
        self.isChecked = isChecked
    }
    func getIsChecked() -> Bool {
        return self.isChecked!
    }
}


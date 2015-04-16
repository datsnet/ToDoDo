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
    var todoTitle: String!

    convenience init(isChecked: Bool, todoTitle: String) {
        self.init()
        self.isChecked = isChecked
        self.todoTitle = todoTitle
    }
    func getTodoTitle() -> String {
        return todoTitle!
    }
    func todoTitle(todoTitle: String) {
        self.todoTitle = todoTitle
    }
    func isChecked(isChecked: Bool) {
        self.isChecked = isChecked
    }
    func getIsChecked() -> Bool {
        return self.isChecked!
    }
}


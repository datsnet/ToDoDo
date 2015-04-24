//
//  ToDoDoTests.swift
//  ToDoDoTests
//
//  Created by 熱海 大介 on 2015/02/13.
//  Copyright (c) 2015年 com.datsnet. All rights reserved.
//

import UIKit
import XCTest
import ToDoDo

class ToDoDoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSelectAllTodoItem() {
        let manager = TodoCoreDataManager.sharedInstance
        let results = manager.selectAllTodoItem()
        if (results?.count < 0) {
            //            XCTAssert(expression: BooleanType, <#message: String#>)
            XCTAssertNil(results, "OK")
        }
    }
    
    func testinsertTodoItem() {
        let manager = TodoCoreDataManager.sharedInstance
        XCTAssert(manager.insertTodoItem("test"), "OK")
    }
    
    func testInsertTodoCategoryItem() {
        let manager = TodoCoreDataManager.sharedInstance
        XCTAssert(manager.insertTodoCategoryItem("test").0, "OK")
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}

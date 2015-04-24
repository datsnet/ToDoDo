//
//  TodoListViewController.swift
//  ToDoDo
//
//  Created by 熱海 大介 on 2015/02/14.
//  Copyright (c) 2015年 com.datsnet. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class TodoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TodoTableViewCellDelegate, UITextFieldDelegate {


    @IBOutlet weak var todoAddField: UITextField!
    
    @IBOutlet weak var addItemTextField: UITextField!
    @IBOutlet var tableView: UITableView!
    var todoTableViewCell: TodoTableViewCell!
    var todoItems = [TodoItem]()
    var category: Category!
    var test = String()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        //カスタムセルを指定
        let nib  = UINib(nibName: "TotoTableViewCell", bundle:nil)
        tableView.registerNib(nib, forCellReuseIdentifier:"TodoTableViewCell")
        // TODO DBから値を取得して表示する
        let manager = TodoCoreDataManager.sharedInstance
//        let results: [AnyObject]! = manager.selectAllTodoItem()
        let results: [AnyObject]! = manager.selectTodoItemByCategory(Category: self.category)
        
        for var i = 0; i < results?.count; i++ {
            
            if let todo = results[i] as? Todo {
                var todoItem: TodoItem = TodoItem()
                todoItem.todoTitle = todo.name
                todoItem.isChecked = todo.complete.boolValue
                todoItems.insert(todoItem, atIndex: i)
            }
        }
    }
    
    func todoAdd(todoText: String) {
        NSLog("todoText : %@", todoText)
        
        if (todoText.isEqual(nil)) {
            return
        }
        
        // TODO DBに入れる
        
        // TODO テーブルに表示する
        // テーブルの先頭に新規アイテムを挿入する
        // データソースの更新
//        let entity = NSEntityDescription.entityForName("Todo", inManagedObjectContext: managedObjectContext!)
//        let todo = Todo(entity: entity!, insertIntoManagedObjectContext: managedObjectContext)
//
//        todo.name = todoText as String
//        todo.complete = 0
//        CoreDataManager.saveContext(managedObjectContext!)
        
        let manager = TodoCoreDataManager.sharedInstance
        manager.insertTodoItem(todoText, Category: self.category)
        
        var item = TodoItem(isChecked: false, todoTitle: todoText as String)
        todoItems.insert(item, atIndex: 0)
        // テーブルビューの更新
        tableView?.reloadData();
    }
    
    // #pragma mark - Table View
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        var editRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Edit", handler:{action, indexpath in
            println("EDIT•ACTION")
            var inputTextField: UITextField?
            
            let alertController: UIAlertController = UIAlertController(title: "カテゴリの編集", message: "edit category name", preferredStyle: .Alert)
            
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
                println("Pushed CANCEL")
            }
            alertController.addAction(cancelAction)
            
            let editAction: UIAlertAction = UIAlertAction(title: "edit", style: .Default) { action -> Void in
                println("add category")
                println(inputTextField?.text)
//                self.insertNewCategory(inputTextField!.text)
            }
            alertController.addAction(editAction)
            
            alertController.addTextFieldWithConfigurationHandler { textField -> Void in
                //                inputTextField = textField
                textField.placeholder = "category name"
//                textField.text = self.objects[indexPath.row] as String
            }
            self.presentViewController(alertController, animated: true, completion: nil)
            
        });
        editRowAction.backgroundColor = UIColor(red: 0.298, green: 0.851, blue: 0.3922, alpha: 1.0);
        
        var deleteRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete", handler:{action, indexpath in
            println("DELETE•ACTION");
//            self.objects.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)});
        
        return [deleteRowAction, editRowAction];
    }

    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {
        return todoItems.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        let cell: TodoTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("TodoTableViewCell", forIndexPath: indexPath) as! TodoTableViewCell
        cell.delegate = self
        let item = todoItems[indexPath.row]
        cell.todoTitle.text = item.todoTitle
        designCheckButton(cell, indexPath: indexPath)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
        let todoDetailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("TodoDetailViewController") as! TodoDetailViewController
        navigationController?.pushViewController(todoDetailViewController, animated: true)
        
    }
    
    func designCheckButton(cell: TodoTableViewCell, indexPath: NSIndexPath) {
        let checkButton = cell.checkButton
        var item = todoItems[indexPath.row]
        var text = NSAttributedString()
        if item.isChecked == true {
            checkButton.setImage(UIImage(named: "done"), forState: UIControlState.Normal)
            text = NSAttributedString(string: item.todoTitle! as String, attributes: [
                NSStrikethroughStyleAttributeName : NSUnderlineStyle.StyleSingle.rawValue,
                ])
        } else {
            checkButton.setImage(UIImage(named: "yet"), forState: UIControlState.Normal)
            text = NSAttributedString(string: item.todoTitle! as String, attributes: [
                NSStrikethroughStyleAttributeName : NSUnderlineStyle.StyleNone.rawValue,
                ])
        }
        
        cell.todoTitle.attributedText = text
    }
    
    func toggleCheckButton(cell: TodoTableViewCell, indexPath: NSIndexPath) {
        let checkButton = cell.checkButton
        var item = todoItems[indexPath.row]
        var text = NSAttributedString()
        if item.isChecked == true {
            item.isChecked = false
            checkButton.setImage(UIImage(named: "yet"), forState: UIControlState.Normal)
            text = NSAttributedString(string: item.todoTitle! as String, attributes: [
                NSStrikethroughStyleAttributeName : NSUnderlineStyle.StyleNone.rawValue,
                ])
        } else {
            item.isChecked = true
            checkButton.setImage(UIImage(named: "done"), forState: UIControlState.Normal)
            text = NSAttributedString(string: item.todoTitle! as String, attributes: [
                NSStrikethroughStyleAttributeName : NSUnderlineStyle.StyleSingle.rawValue,
                ])
        }
        
        cell.todoTitle.attributedText = text
    }
    
    // MARK: delegate
    func cellClick(cell: TodoTableViewCell) {
        let indexPath = tableView.indexPathForCell(cell)!
        toggleCheckButton(cell, indexPath: indexPath)
    }
    
    func checkButtonClick(cell: TodoTableViewCell) {
        let indexPath = tableView.indexPathForCell(cell)!
        toggleCheckButton(cell, indexPath: indexPath)
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.text == "" { return true }
        textField.resignFirstResponder()
//        println(textField.text)
//        var item = TodoItem()
//        item.todoTitle = textField.text
//        self.todoItems.insert(item, atIndex: 0)
//        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
//        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
//        
//        // フィールドを消す
//        textField.text = ""
        todoAdd(textField.text)
        return false;
    }
}



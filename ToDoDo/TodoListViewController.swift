//
//  TodoListViewController.swift
//  ToDoDo
//
//  Created by 熱海 大介 on 2015/02/14.
//  Copyright (c) 2015年 com.datsnet. All rights reserved.
//

import Foundation
import UIKit

class TodoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TodoTableViewCellDelegate, UITextFieldDelegate {


    @IBOutlet weak var todoAddField: UITextField!
    
    @IBOutlet weak var addItemTextField: UITextField!
    @IBOutlet var tableView: UITableView!
    var todoTableViewCell: TodoTableViewCell!
    var todoItems = [TodoItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        //カスタムセルを指定
        let nib  = UINib(nibName: "TotoTableViewCell", bundle:nil)
        tableView.registerNib(nib, forCellReuseIdentifier:"TodoTableViewCell")
        // TODO DBから値を取得して表示する
        var item1 = TodoItem()
        var item2 = TodoItem()
        item1.setTodoTitle("todo1")
        item2.setTodoTitle("todo2")
        todoItems = [item1, item2]
    }
    
    @IBAction func todoAddAction(sender: AnyObject) {
        var todoText: NSString = todoAddField.text
        NSLog("todoText : %@", todoText)
        
        if (todoText.isEqual(nil)) {
            return
        }
        
        // TODO DBに入れる
        
        // TODO テーブルに表示する
        // テーブルの先頭に新規アイテムを挿入する
        // データソースの更新
        var item = TodoItem(isChecked: false, todoTitle: todoText)
        todoItems.insert(item, atIndex: 0)
        // テーブルビューの更新
        tableView?.reloadData();
        // テキストフィールドのクリア
        todoAddField.text = "";
        
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
        let cell: TodoTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("TodoTableViewCell", forIndexPath: indexPath) as TodoTableViewCell
        cell.delegate = self
        let item = todoItems[indexPath.row]
        cell.todoTitle.text = item.todoTitle
        designCheckButton(cell, indexPath: indexPath)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
        
    }
    
    func designCheckButton(cell: TodoTableViewCell, indexPath: NSIndexPath) {
        let checkButton = cell.checkButton
        var item = todoItems[indexPath.row]
        var text = NSAttributedString()
        if item.isChecked == true {
            checkButton.setImage(UIImage(named: "done"), forState: UIControlState.Normal)
            text = NSAttributedString(string: item.todoTitle!, attributes: [
                NSStrikethroughStyleAttributeName : NSUnderlineStyle.StyleSingle.rawValue,
                ])
        } else {
            checkButton.setImage(UIImage(named: "yet"), forState: UIControlState.Normal)
            text = NSAttributedString(string: item.todoTitle!, attributes: [
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
            text = NSAttributedString(string: item.todoTitle!, attributes: [
                NSStrikethroughStyleAttributeName : NSUnderlineStyle.StyleNone.rawValue,
                ])
        } else {
            item.isChecked = true
            checkButton.setImage(UIImage(named: "done"), forState: UIControlState.Normal)
            text = NSAttributedString(string: item.todoTitle!, attributes: [
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
        println(textField.text)
        var item = TodoItem()
        item.todoTitle = textField.text
        self.todoItems.insert(item, atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        
        // フィールドを消す
        textField.text = ""
        return false;
    }
}



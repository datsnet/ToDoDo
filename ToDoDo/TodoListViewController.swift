//
//  TodoListViewController.swift
//  ToDoDo
//
//  Created by 熱海 大介 on 2015/02/14.
//  Copyright (c) 2015年 com.datsnet. All rights reserved.
//

import Foundation
import UIKit

class TodoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TodoTableViewCellDelegate {

    @IBOutlet var tableView : UITableView!
    @IBOutlet weak var todoAddField: UITextField!
    
    var todoTableViewCell: TodoTableViewCell!
    var todoItems = [TodoItem]()
    
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
    override func viewDidLoad() {
        super.viewDidLoad();
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //カスタムセルを指定
        let nib  = UINib(nibName: "TotoTableViewCell", bundle:nil)
        tableView.registerNib(nib, forCellReuseIdentifier:"TodoTableViewCell")
        // TODODBから値を取得して表示する
        var item1 = TodoItem()
        var item2 = TodoItem()
        item1.setTodoTitle("todo1")
        item2.setTodoTitle("todo2")
        todoItems = [item1, item2]
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
        
    }
    
    func checkButtonClick(cell: TodoTableViewCell) {
        let indexPath = tableView.indexPathForCell(cell)!
        toggleCheckButton(cell, indexPath: indexPath)
    }
}



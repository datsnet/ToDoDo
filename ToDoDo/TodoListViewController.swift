//
//  TodoListViewController.swift
//  ToDoDo
//
//  Created by 熱海 大介 on 2015/02/14.
//  Copyright (c) 2015年 com.datsnet. All rights reserved.
//

import Foundation
import UIKit

class TodoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView : UITableView!
    @IBOutlet weak var todoAddField: UITextField!
    
    var todoItem = [String]()
    
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
        todoItem.insert(todoText, atIndex: 0)
        // テーブルビューの更新
        tableView?.reloadData();
        // テキストフィールドのクリア
        todoAddField.text = "";

        
    }
    override func viewDidLoad() {
        super.viewDidLoad();
        
        tableView.delegate = self
        tableView.dataSource = self
        
//        self.tableView.registerClass(TodoTableViewCell.classForCoder(), forCellReuseIdentifier: "TodoTableViewCell")
        //カスタムセルを指定
        
        let nib  = UINib(nibName: "TotoTableViewCell", bundle:nil)
        tableView.registerNib(nib, forCellReuseIdentifier:"TodoTableViewCell")
        // TODODBから値を取得して表示する
        todoItem = ["aa", "aa"]
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {
        return todoItem.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        let cell: TodoTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("TodoTableViewCell", forIndexPath: indexPath) as TodoTableViewCell
//        cell.textLabel?.text = todoItem[indexPath.row]
        cell.todoTitle.text = todoItem[indexPath.row];
//        let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
    }

    
    
}



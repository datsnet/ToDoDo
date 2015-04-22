//
//  TodoListCategoryTableViewController.swift
//  ToDoDo
//
//  Created by 熱海大介 on 2015/03/11.
//  Copyright (c) 2015年 com.datsnet. All rights reserved.
//

import Foundation
import UIKit

class TodoListCategoryTableViewController: UITableViewController {
    var objects = NSMutableArray()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Data Source
        self.objects = NSMutableArray();
        self.objects.insertObject("test", atIndex: 0)
        
        // UI
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "inputFieldBtn:")
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    func insertNewCategory(category: String!) {
        if category == "" {
            return
        }
        objects.insertObject(category, atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
    // #pragma mark - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let indexPath = self.tableView.indexPathForSelectedRow()
            let object = objects[indexPath!.row] as! NSDate
//            (segue.destinationViewController as TodoListViewController).detailItem = object
        }
    }
    
    // #pragma mark - Table View
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    // #pragma mark - Table View
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    // #pragma mark - Table View
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        // TODO DBから取得する
        
        let object = objects[indexPath.row] as! NSString
        cell.textLabel?.text = object.description
        
        return cell
    }
    // #pragma mark - Table View
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    // #pragma mark - Table View
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    // #pragma mark - Table View
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
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
                self.insertNewCategory(inputTextField!.text)
            }
            alertController.addAction(editAction)
            
            alertController.addTextFieldWithConfigurationHandler { textField -> Void in
//                inputTextField = textField
                textField.placeholder = "category name"
                textField.text = self.objects[indexPath.row] as! String
            }
            self.presentViewController(alertController, animated: true, completion: nil)
            
        });
        editRowAction.backgroundColor = UIColor(red: 0.298, green: 0.851, blue: 0.3922, alpha: 1.0);
        
        var deleteRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete", handler:{action, indexpath in
            println("DELETE•ACTION");
            self.objects.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)});
        
        return [deleteRowAction, editRowAction];
    }
    
    // #pragma mark - Table View
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
//        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("TodoListViewController") as TodoListViewController
//        navigationController?.pushViewController(SampleViewController(), animated: true)
        
        let todoListViewController = self.storyboard?.instantiateViewControllerWithIdentifier("TodoListViewController") as! TodoListViewController
        navigationController?.pushViewController(todoListViewController, animated: true)
    }
    
    
    @IBAction func inputFieldBtn(sender: UIButton) {
        var inputTextField: UITextField?
        
        let alertController: UIAlertController = UIAlertController(title: "新規カテゴリの入力", message: "input category name", preferredStyle: .Alert)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            println("Pushed CANCEL")
        }
        alertController.addAction(cancelAction)
        
        let addAction: UIAlertAction = UIAlertAction(title: "add", style: .Default) { action -> Void in
            let inputText = inputTextField!.text
            // DBに入れる
            let manager = TodoCoreDataManager.sharedInstance
            manager.insertTodoCategoryItem(inputText)
            self.insertNewCategory(inputText)
        }
        alertController.addAction(addAction)
        
        alertController.addTextFieldWithConfigurationHandler { textField -> Void in
            inputTextField = textField
            textField.placeholder = "category name"
        }

        
        presentViewController(alertController, animated: true, completion: nil)
    }

}
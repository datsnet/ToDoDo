//
//  TodoDetailViewController.swift
//  ToDoDo
//
//  Created by 熱海大介 on 2015/04/08.
//  Copyright (c) 2015年 com.datsnet. All rights reserved.
//

import Foundation
import UIKit

class TodoDetailViewController: UIViewController, DatePickerDelegate {
    @IBOutlet weak var limitButton: UIButton!
    @IBOutlet weak var reminderButton: UIButton!
    var datePicker: DatePickerView!
    override func viewDidLoad() {
        datePicker = DatePickerView.instance()
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let width = screenSize.width
        let height = screenSize.height
        datePicker.delegate = self
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        closeDatePicker()
    }
    
//    @IBAction func dateChanged(sender: AnyObject) {
//        let buttonLabel = "期限日：" + format(datePicker.date, style: "yyyy/MM/dd/(E)")
//        limitButton.setTitle(buttonLabel, forState: .Normal)
//    }
    @IBAction func clickLimitation(sender: AnyObject) {
        showDatePicker()
    }
    @IBAction func clickReminder(sender: AnyObject) {
    }
    
    // 書式指定に従って日付を文字列に変換します
    // パラメータ
    //  date : 日付データ(NSDate型)を指定します
    //  style : 書式を指定します
    //          yyyy 西暦,MM 月,dd 日,HH 時,mm 分,ss 秒
    //
    func format(date : NSDate, style: String) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale.systemLocale()
        dateFormatter.dateFormat = style
        return  dateFormatter.stringFromDate(date)
    }
    
    func showDatePicker() {
        if ((datePicker) == nil) {
            datePicker = DatePickerView.instance()
        }
        datePicker.frame.origin.x = 0
        datePicker.frame.origin.y = self.view.frame.height - datePicker.frame.height
        
        self.view.addSubview(datePicker)
        datePicker.delegate = self
    }
    func closeDatePicker() {
        if (datePicker != nil) {
            datePicker.removeFromSuperview()
            datePicker = nil
        }
    }
    
    // MARK DatePickerDelegate
    func doneAction() {
        let date = format(datePicker.datePicker.date, style: "yyyy/MM/dd/ (E)")
        limitButton.setTitle("期限日: " + date, forState: .Normal)        
        closeDatePicker()
    }
    func cancelAction() {
        closeDatePicker()
    }
    
}

//
//  DatePickerView.swift
//  ToDoDo
//
//  Created by 熱海大介 on 2015/04/15.
//  Copyright (c) 2015年 com.datsnet. All rights reserved.
//

import Foundation
import UIKit

class DatePickerView: UIView {
    
    var delegate: DatePickerDelegate! = nil
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBAction func doneAction(sender: AnyObject) {
        delegate.doneAction()
    }
    @IBAction func cancelAction(sender: AnyObject) {
        delegate.cancelAction()
    }
    
    class func instance() -> DatePickerView {
        
        let datePickerView = UINib(nibName: "DatePickerView", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! DatePickerView
        return datePickerView
    }
}

protocol DatePickerDelegate{
    func doneAction()
    func cancelAction()
}

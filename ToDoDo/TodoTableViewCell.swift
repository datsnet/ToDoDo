//
//  TodoTableViewCell.swift
//  ToDoDo
//
//  Created by 熱海 大介 on 2015/02/15.
//  Copyright (c) 2015年 com.datsnet. All rights reserved.
//

import Foundation
import UIKit

class TodoTableViewCell: UITableViewCell {
    weak var delegate: TodoTableViewCellDelegate?
    @IBOutlet weak var todoTitle: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    @IBAction func checkButtonAction(sender: AnyObject) {
        delegate?.checkButtonClick(self)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // UILabelとかを追加
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}

protocol TodoTableViewCellDelegate: class {
    // セルをタップした時に通知する
    func cellClick(cell: TodoTableViewCell)->Void
    func checkButtonClick(cell: TodoTableViewCell)->Void
}
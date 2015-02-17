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
    @IBOutlet weak var todoTitle: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    @IBAction func checkButtonAction(sender: AnyObject) {
        NSLog("%@", "押された！！")

        if let checkButton = sender as? UIButton {
            checkButton.setImage(UIImage(named: "done"), forState: UIControlState.Normal)
        }
        let text = NSAttributedString(string: todoTitle.text!, attributes: [
            NSStrikethroughStyleAttributeName : NSUnderlineStyle.StyleSingle.rawValue,
            // 取り消し線に色つけるなら下記
            NSStrikethroughColorAttributeName: UIColor.redColor()
            ])
        todoTitle.attributedText = text
        
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
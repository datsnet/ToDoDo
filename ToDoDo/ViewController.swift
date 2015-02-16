//
//  ViewController.swift
//  ToDoDo
//
//  Created by 熱海 大介 on 2015/02/13.
//  Copyright (c) 2015年 com.datsnet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var pageMenu : CAPSPageMenu?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Array to keep track of controllers in page menu
        var controllerArray : [UIViewController] = []
        
        // Create variables for all view controllers you want to put in the
        // page menu, initialize them, and add each to the controller array.
        // (Can be any UIViewController subclass)
        // Make sure the title property of all view controllers is set
        // Example:
        var controller1 : TodoListViewController = TodoListViewController(nibName: "TodoListViewController", bundle: nil)
        controller1.title = "SAMPLE TITLE1"
        controllerArray.append(controller1)
        
        
        var controller2 : TodoListViewController = TodoListViewController(nibName: "TodoListViewController", bundle: nil)
        controller2.title = "SAMPLE TITLE2"
        controllerArray.append(controller2)
        
        var controller3 : TodoListViewController = TodoListViewController(nibName: "TodoListViewController", bundle: nil)
        controllerArray.append(controller3)
        
        // Customize page menu to your liking (optional) or use default settings by sending nil for 'options' in the init
        // Example:
        var parameters: [String: AnyObject] = ["menuItemSeparatorWidth": 4.3,
            "scrollMenuBackgroundColor": UIColor.whiteColor(),
            "viewBackgroundColor": UIColor(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1.0),
            "bottomMenuHairlineColor": UIColor(red: 20.0/255.0, green: 20.0/255.0, blue: 20.0/255.0, alpha: 0.1),
            "selectionIndicatorColor": UIColor(red: 18.0/255.0, green: 150.0/255.0, blue: 225.0/255.0, alpha: 1.0),
            "menuMargin": 20.0,
            "menuHeight": 40.0,
            "selectedMenuItemLabelColor": UIColor(red: 18.0/255.0, green: 150.0/255.0, blue: 225.0/255.0, alpha: 1.0),
            "unselectedMenuItemLabelColor": UIColor(red: 40.0/255.0, green: 40.0/255.0, blue: 40.0/255.0, alpha: 1.0),
            "menuItemFont": UIFont(name: "HelveticaNeue-Medium", size: 14.0)!,
            "useMenuLikeSegmentedControl": true,
            "menuItemSeparatorRoundEdges": true,
            "selectionIndicatorHeight": 2.0,
            "menuItemSeparatorPercentageHeight": 0.1]
        
        // Initialize page menu with controller array, frame, and optional parameters
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, 0.0, self.view.frame.width, self.view.frame.height), options: parameters)
        
        // Lastly add page menu as subview of base view controller view
        // or use pageMenu controller in you view hierachy as desired
        self.view.addSubview(pageMenu!.view)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  LightContentNavigationController.swift
//  Review
//
//  Created by tstone10 on 2019/8/7.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import UIKit

public class LightContentNavigationController: UINavigationController {

    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.barTintColor = ColorKit.navigationBar.value
        navigationBar.setValue(true, forKey: "hidesShadow")
        let textAttributes = [NSAttributedString.Key.foregroundColor: ColorKit.cloudColor.value!]
        navigationBar.titleTextAttributes = textAttributes
    }
}

//
//  LightContentNavigationController.swift
//  Review
//
//  Created by tstone10 on 2019/8/7.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import UIKit

class LightContentNavigationController: UINavigationController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.barTintColor = ColorKit.electronBlue.value
        let textAttributes = [NSAttributedString.Key.foregroundColor: ColorKit.reviewCardBackgroundColor.value!]
        navigationBar.titleTextAttributes = textAttributes
    }
}

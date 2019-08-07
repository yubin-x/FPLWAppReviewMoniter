//
//  PhoneTabBarController.swift
//  Review
//
//  Created by tstone10 on 2019/8/6.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import UIKit
import ReviewUIKit

class PhoneTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let phoneReviewVC = ViewControllerFactory.makePhoneReviewViewController()
        phoneReviewVC.tabBarItem = TabBarItems.reviewTabBarItem()
        
        let settingVC = ViewControllerFactory.makeSettingViewController()
        settingVC.tabBarItem = TabBarItems.settingTabBarItem()
        
        viewControllers = [phoneReviewVC, settingVC]
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : ColorKit.nameLabelColor.value!], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : ColorKit.electronBlue.value!], for: .selected)
        
        tabBar.barTintColor = ColorKit.backgroundColor.value
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

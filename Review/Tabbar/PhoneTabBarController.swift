//
//  PhoneTabBarController.swift
//  Review
//
//  Created by tstone10 on 2019/8/6.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import UIKit

class PhoneTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let phoneReviewVC = ViewControllerFactory.makePhoneReviewViewController()
        let phoneReviewNav = UINavigationController(rootViewController: phoneReviewVC)
        phoneReviewNav.tabBarItem = UITabBarItem(title: "Review",
                                                 image: ImageKit.reviewTabBarImage.value,
                                                 selectedImage: ImageKit.reviewTabBarSelectedImage.value)
        
        let settingVC = ViewControllerFactory.makeSettingViewController()
        let settingNav = UINavigationController(rootViewController: settingVC)
        settingNav.tabBarItem = UITabBarItem(title: "Setting",
                                             image: ImageKit.settingTabBarImage.value,
                                             selectedImage: ImageKit.settingTabBarSelectedImage.value)
        
        viewControllers = [settingNav]
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], for: .normal)
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

//
//  TabBarItems.swift
//  ReviewUIKit
//
//  Created by 朱廷 on 2019/8/7.
//  Copyright © 2019 朱廷. All rights reserved.
//

import UIKit

public struct TabBarItems {
    public static func reviewTabBarItem() -> UITabBarItem {
        return UITabBarItem(title: "Review",
                            image: ImageKit.reviewTabBarImage.value,
                            selectedImage: ImageKit.reviewTabBarSelectedImage.value)
    }
    
    public static func settingTabBarItem() -> UITabBarItem {
        return UITabBarItem(title: "Setting",
                            image: ImageKit.settingTabBarImage.value,
                            selectedImage: ImageKit.settingTabBarSelectedImage.value)
    }
}

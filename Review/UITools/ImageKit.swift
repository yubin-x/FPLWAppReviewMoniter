//
//  ImageKit.swift
//  Review
//
//  Created by tstone10 on 2019/8/6.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import UIKit

enum ImageKit {
    case reviewTabBarImage
    case reviewTabBarSelectedImage
    case settingTabBarImage
    case settingTabBarSelectedImage
    
    var value: UIImage? {
        switch self {
        case .reviewTabBarImage:
            return UIImage(named: "reivew-item")
        case .reviewTabBarSelectedImage:
            return UIImage(named: "review-unselected-item")
        case .settingTabBarImage:
            return UIImage(named: "settings-unselected-item")
        case .settingTabBarSelectedImage:
            return UIImage(named: "settings-item")
        }
    }
}

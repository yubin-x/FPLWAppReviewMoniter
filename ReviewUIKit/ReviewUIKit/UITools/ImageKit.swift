//
//  ImageKit.swift
//  Review
//
//  Created by tstone10 on 2019/8/6.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import UIKit

public enum ImageKit {
    case reviewTabBarImage
    case reviewTabBarSelectedImage
    case settingTabBarImage
    case settingTabBarSelectedImage
    case menuICONImage
    case addAppICONImage
    case refreshICONImage
    
    public var value: UIImage? {
        return UIImage(named: imageName)
    }
    
    private var imageName: String {
        switch self {
        case .reviewTabBarImage:
            return "review-unselected-item"
        case .reviewTabBarSelectedImage:
            return "reivew-item"
        case .settingTabBarImage:
            return "settings-unselected-item"
        case .settingTabBarSelectedImage:
            return "settings-item"
        case .menuICONImage:
            return "menu"
        case .addAppICONImage:
            return "plus"
        case .refreshICONImage:
            return "refresh"
        }
    }
}

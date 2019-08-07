//
//  BarButtonItems.swift
//  ReviewUIKit
//
//  Created by 朱廷 on 2019/8/7.
//  Copyright © 2019 朱廷. All rights reserved.
//

import UIKit

public struct BarButtonItems {
    public static func plainBarButtonItemWith(image: UIImage?) -> UIBarButtonItem {
        return UIBarButtonItem(image: image,
                               style: UIBarButtonItem.Style.plain,
                               target: nil,
                               action: nil)
    }
    
    public static func plainBarButtonItemWith(title: String) -> UIBarButtonItem {
        let item = UIBarButtonItem(title: title,
                                   style: UIBarButtonItem.Style.plain,
                                   target: nil,
                                   action: nil)
        item.tintColor = ColorKit.cloudColor.value
        return item
    }
    
    public static func systemItemAdd() -> UIBarButtonItem {
        let item = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add,
                                   target: nil,
                                   action: nil)
        item.tintColor = ColorKit.cloudColor.value
        return item
    }
}

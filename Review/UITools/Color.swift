//
//  FontKit.swift
//  Review
//
//  Created by tstone10 on 2019/8/6.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import UIKit

enum ColorKit {
    case labelTextColor
    case subLabelTextColor
    case backgroundColor
    case nameLabelColor
    case reviewCardBackgroundColor
    
    var value: UIColor? {
        switch self {
        case .labelTextColor:
            return UIColor.darkText
        case .subLabelTextColor:
            return UIColor.lightGray
        case .backgroundColor:
            return UIColor.white
        case .nameLabelColor:
            return UIColor(named: "color/nameLabelColor")
        case .reviewCardBackgroundColor:
            return UIColor(named: "color/reviewCardBackgroundColor")
        }
    }
}

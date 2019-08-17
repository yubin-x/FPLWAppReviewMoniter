//
//  FontKit.swift
//  Review
//
//  Created by tstone10 on 2019/8/6.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import UIKit

public enum FontKit {
    case userNameFont
    case labelFont
    case subLabelFont
    case rightInfoLabelFont
    case nameLabelFont
    case reviewContentFont
    case reviewTitleFont
    case boldLabelFont
    
    public var value: UIFont {
        switch self {
        case .userNameFont:
            return UIFont.boldSystemFont(ofSize: 17)
        case .labelFont:
            return UIFont.systemFont(ofSize: 17)
        case .subLabelFont:
            return UIFont.systemFont(ofSize: 13)
        case .rightInfoLabelFont:
            return UIFont.systemFont(ofSize: 14)
        case .nameLabelFont, .reviewContentFont:
            return UIFont.systemFont(ofSize: 15)
        case .reviewTitleFont:
            return UIFont.boldSystemFont(ofSize: 15)
        case .boldLabelFont:
            return UIFont.boldSystemFont(ofSize: 17)
        }
    }
}

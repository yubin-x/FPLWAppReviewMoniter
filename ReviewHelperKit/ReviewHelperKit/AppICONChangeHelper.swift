//
//  AppICONChangeHelper.swift
//  ReviewHelperKit
//
//  Created by tstone10 on 2019/8/16.
//  Copyright © 2019 朱廷. All rights reserved.
//

import UIKit

public enum AppICONType: String {
    case primary
    case second
    case third

    public static func currentType() -> AppICONType {
        let appName = UIApplication.shared.alternateIconName ?? "primary"
        return AppICONType(rawValue: appName) ?? AppICONType.primary
    }

    public static func currentTypeInde() -> Int {
        let appName = UIApplication.shared.alternateIconName ?? "primary"
        let type = AppICONType(rawValue: appName) ?? AppICONType.primary
        switch type {
        case .primary:
            return 0
        case .second:
            return 1
        case .third:
            return 2
        }
    }
}

public struct AppICONChangeHelper {
    public static func setAppICON(type: AppICONType) {
        let imageName: String?
        switch type {
        case .primary:
            imageName = nil
        default:
            imageName = type.rawValue
        }
        UIApplication.shared.setAlternateIconName(imageName, completionHandler: nil)
    }

    public static func setAppICON(index: Int) {
        let imageName: String?
        switch index {
        case 1:
            imageName = AppICONType.second.rawValue
        case 2:
            imageName = AppICONType.third.rawValue
        default:
            imageName = nil
        }
        UIApplication.shared.setAlternateIconName(imageName, completionHandler: nil)
    }
}

//
//  Labels.swift
//  ReviewUIKit
//
//  Created by 朱廷 on 2019/8/7.
//  Copyright © 2019 朱廷. All rights reserved.
//

import UIKit

public struct Labels {
    public static func h1Label() -> UILabel {
        let label = UILabel()
        label.font = FontKit.labelFont.value
        return label
    }
    
    public static func h2Label() -> UILabel {
        let label = UILabel()
        label.font = FontKit.reviewContentFont.value
        label.numberOfLines = 0
        return label
    }
    
    public static func grayH2Label() -> UILabel {
        let label = UILabel()
        label.font = FontKit.nameLabelFont.value
        label.textAlignment = .right
        label.textColor = ColorKit.nameLabelColor.value
        return label
    }
    
    public static func appInfoLabel() -> UILabel {
        let label = UILabel()
        label.font = FontKit.rightInfoLabelFont.value
        label.textColor = ColorKit.subLabelTextColor.value
        label.textAlignment = .center
        return label
    }
    
    public static func countryLabel() -> UILabel {
        let label = UILabel()
        label.font = FontKit.labelFont.value
        label.textAlignment = .center
        label.textColor = ColorKit.electronBlue.value
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.layer.borderColor = ColorKit.electronBlue.value?.cgColor
        label.layer.borderWidth = 1
        return label
    }
    
    public static func boldLabel() -> UILabel {
        let label = UILabel()
        label.font = FontKit.boldLabelFont.value
        return label
    }
}

//
//  Buttons.swift
//  ReviewUIKit
//
//  Created by tstone10 on 2019/8/16.
//  Copyright © 2019 朱廷. All rights reserved.
//

import UIKit

public struct Buttons {
    public static func appICONButton() -> UIButton {
        let button = UIButton()
        button.imageView?.layer.borderWidth = 2
        button.imageView?.layer.borderColor = UIColor.clear.cgColor
        button.imageView?.layer.cornerRadius = 15
        button.imageView?.layer.masksToBounds = true
        return button
    }
}

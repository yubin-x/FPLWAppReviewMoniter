//
//  TextField.swift
//  ReviewUIKit
//
//  Created by 朱廷 on 2019/8/7.
//  Copyright © 2019 朱廷. All rights reserved.
//

import UIKit

public struct TextFields {
    public static func uneditableTextField() -> UITextField {
        let textField = UITextField()
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.textAlignment = .center
        return textField
    }
}

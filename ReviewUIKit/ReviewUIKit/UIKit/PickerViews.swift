//
//  PickerViews.swift
//  ReviewUIKit
//
//  Created by tstone10 on 2019/8/9.
//  Copyright © 2019 朱廷. All rights reserved.
//

import UIKit

public struct PickerView {
    public static func countryPickerView() -> UIPickerView {
        let pickerView = UIPickerView()
        pickerView.showsSelectionIndicator = true
        pickerView.backgroundColor = ColorKit.backgroundColor.value
        return pickerView
    }
}

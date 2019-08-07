//
//  Views.swift
//  ReviewUIKit
//
//  Created by 朱廷 on 2019/8/7.
//  Copyright © 2019 朱廷. All rights reserved.
//

import UIKit

public struct Views {
    public static func cardContentView() -> UIView {
        let view = UIView()
        view.backgroundColor = ColorKit.cloudColor.value
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }
}

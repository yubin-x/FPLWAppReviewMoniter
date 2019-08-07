//
//  ImageViews.swift
//  ReviewUIKit
//
//  Created by 朱廷 on 2019/8/7.
//  Copyright © 2019 朱廷. All rights reserved.
//

import UIKit

public struct ImageViews {
    public static func appICONImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }
}

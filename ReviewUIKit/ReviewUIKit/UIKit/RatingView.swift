//
//  RatingView.swift
//  ReviewUIKit
//
//  Created by 朱廷 on 2019/8/7.
//  Copyright © 2019 朱廷. All rights reserved.
//

import Cosmos

public class RatingView: CosmosView {
    
    public static func quickInit() -> RatingView {
        var setting = CosmosSettings.default
        setting.filledBorderColor = ColorKit.carrot.value!
        setting.filledColor = ColorKit.carrot.value!
        setting.emptyBorderColor = ColorKit.carrot.value!
        setting.fillMode = .precise
        setting.updateOnTouch = false
        let view = RatingView(settings: setting)
        return view
    }
}

//
//  RatingView.swift
//  ReviewUIKit
//
//  Created by 朱廷 on 2019/8/7.
//  Copyright © 2019 朱廷. All rights reserved.
//

import Cosmos

public class RatingView: CosmosView {
    
    public static func fiveStartRatingView() -> RatingView {
        var setting = CosmosSettings.default
        setting.filledBorderColor = ColorKit.midnightBlue.value!
        setting.filledColor = ColorKit.midnightBlue.value!
        setting.emptyBorderColor = ColorKit.midnightBlue.value!
        setting.fillMode = .precise
        setting.updateOnTouch = false
        setting.starSize = 15
        let view = RatingView(settings: setting)
        return view
    }
    
    public static func oneStartRatingView() -> RatingView {
        var setting = CosmosSettings.default
        setting.filledBorderColor = ColorKit.nameLabelColor.value!
        setting.filledColor = ColorKit.nameLabelColor.value!
        setting.emptyBorderColor = ColorKit.nameLabelColor.value!
        setting.fillMode = .precise
        setting.updateOnTouch = false
        setting.starSize = 15
        setting.totalStars = 1
        let view = RatingView(settings: setting)
        view.rating = 1
        return view
    }
}

//
//  AppInfoModel.swift
//  Review
//
//  Created by Wenslow on 2019/1/11.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import AppStoreReviewAPILayer
import CacheKit

public struct AppInfoModel {
    public let appName: String
    public let iconURLString: String
    public let appId: Int
    public let averageUserRating: Double?
    
    public init(appName: String?,
                iconURLString: String?,
                appId: Int?,
                averageUserRating: Double?) {
        self.appName = appName ?? ""
        self.iconURLString = iconURLString ?? ""
        self.appId = appId ?? 0
        self.averageUserRating = averageUserRating
    }
    
    public init(from appSearchResponse: AppSearchResponse) {
        self.appName = appSearchResponse.appName
        self.iconURLString = appSearchResponse.iconURLString
        self.appId = appSearchResponse.appId
        self.averageUserRating = appSearchResponse.averageUserRating
    }
    
    public init(from appDataEntry: AppDataEntry) {
        self.appName = appDataEntry.appName ?? ""
        self.iconURLString = appDataEntry.iconURLString ?? ""
        self.appId = Int(appDataEntry.appId)
        self.averageUserRating = appDataEntry.averageUserRating
    }
}

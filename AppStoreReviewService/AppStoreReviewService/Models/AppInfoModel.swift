//
//  AppInfoModel.swift
//  Review
//
//  Created by Wenslow on 2019/1/11.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import AppStoreReviewAPILayer
import CacheKit
import ReviewHelperKit

public struct AppInfoModel {
    public let appName: String
    public let iconURLString: String
    public let appId: Int
    public let averageUserRating: Double?
    public let country: Country
    public let genres: [String]
    public let artistName: String
    
    public init(appName: String?,
                iconURLString: String?,
                appId: Int?,
                averageUserRating: Double?,
                country: Country,
                genres: [String] = [],
                artistName: String = "") {
        self.appName = appName ?? ""
        self.iconURLString = iconURLString ?? ""
        self.appId = appId ?? 0
        self.averageUserRating = averageUserRating
        self.country = country
        self.genres = genres
        self.artistName = artistName
    }
    
    public init(from appSearchResponse: AppSearchResponse) {
        self.appName = appSearchResponse.appName
        self.iconURLString = appSearchResponse.iconURLString
        self.appId = appSearchResponse.appId
        self.averageUserRating = appSearchResponse.averageUserRating
        self.country = ConfigurationProvidor.currentCountry
        self.genres = appSearchResponse.genres
        self.artistName = appSearchResponse.artistName
    }
    
    public init(from appDataEntry: AppDataEntry) {
        self.appName = appDataEntry.appName ?? ""
        self.iconURLString = appDataEntry.iconURLString ?? ""
        self.appId = Int(appDataEntry.appId)
        self.averageUserRating = appDataEntry.averageUserRating
        self.country = Country(rawValue: appDataEntry.country ?? "cn") ?? .china
        self.genres = appDataEntry.genres ?? [" ", " "]
        self.artistName = appDataEntry.artistName ?? " "
    }
}

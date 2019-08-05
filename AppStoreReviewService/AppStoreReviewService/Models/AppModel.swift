//
//  AppModel.swift
//  Review
//
//  Created by Wenslow on 2019/1/11.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import Foundation

public struct AppSearchResult: Decodable {
    let results: [AppModel]
}

public struct AppModel: Decodable {
    public let appName: String
    public let iconURLString: String
    public let appId: Int
    public let averageUserRating: Double?
    
    enum CodingKeys: String, CodingKey {
        case appName = "trackName"
        case iconURLString = "artworkUrl60"
        case appId = "trackId"
        case averageUserRating
    }
    
    public init(appName: String?,
                iconURLString: String?,
                appId: Int?,
                averageUserRating: Double?) {
        self.appName = appName ?? ""
        self.iconURLString = iconURLString ?? ""
        self.appId = appId ?? 0
        self.averageUserRating = averageUserRating
    }
}

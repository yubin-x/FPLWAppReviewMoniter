//
//  AppSearchResult.swift
//  Review
//
//  Created by Wenslow on 2019/1/11.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import Foundation

public struct AppSearchResult: Decodable {
    let results: [AppSearchResponse]
}

public struct AppSearchResponse: Decodable {
    public let appName: String
    public let iconURLString: String
    public let appId: Int
    public let averageUserRating: Double?
    public let genres: [String]
    public let artistName: String
    
    enum CodingKeys: String, CodingKey {
        case appName = "trackName"
        case iconURLString = "artworkUrl100"
        case appId = "trackId"
        case averageUserRating
        case genres
        case artistName
    }
    
    public init(appName: String?,
                iconURLString: String?,
                appId: Int?,
                averageUserRating: Double?,
                genres: [String],
                artistName: String) {
        self.appName = appName ?? ""
        self.iconURLString = iconURLString ?? ""
        self.appId = appId ?? 0
        self.averageUserRating = averageUserRating
        self.genres = genres
        self.artistName = artistName
    }
}

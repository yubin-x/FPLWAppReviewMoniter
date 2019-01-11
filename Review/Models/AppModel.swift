//
//  AppModel.swift
//  Review
//
//  Created by Wenslow on 2019/1/11.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import Foundation

struct AppSearchResult: Decodable {
    let results: [AppModel]
}

struct AppModel: Decodable {
    let appName: String
    let iconURLString: String
    let appId: Int
    let averageUserRating: Double?
    
    enum CodingKeys: String, CodingKey {
        case appName = "trackName"
        case iconURLString = "artworkUrl60"
        case appId = "trackId"
        case averageUserRating
    }
}

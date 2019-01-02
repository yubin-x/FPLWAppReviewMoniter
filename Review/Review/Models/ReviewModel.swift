//
//  ReviewModel.swift
//  Review
//
//  Created by Wenslow on 2019/1/2.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import Foundation

struct ReviewModel: Decodable {
    var feed: ReviewFeedModel
}

struct ReviewFeedModel: Decodable {
    var entry: [ReviewEntryModel]
}

struct ReviewEntryModel: Decodable {
    var author: ReviewAuthorModel
}

struct ReviewAuthorModel: Decodable {
    var name: ReviewNameModel
}

struct ReviewNameModel: Decodable {
    var label: String
}

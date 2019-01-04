//
//  ReviewModel.swift
//  Review
//
//  Created by Wenslow on 2019/1/2.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import Foundation

struct ReviewModel: Decodable {
    var feed: FeedModel
}

struct FeedModel: Decodable {
    var entry: [EntryModel]
}

struct EntryModel: Decodable {
    var author: AuthorModel
    var rating: RatingModel
    var title: TitleModel
    var content: ContentModel
    
    enum CodingKeys: String, CodingKey {
        case author
        case rating = "im:rating"
        case title
        case content
    }
}

struct AuthorModel: Decodable {
    var name: NameModel
}

struct NameModel: Decodable {
    var label: String
}

struct RatingModel: Decodable {
    var label: String
}

struct TitleModel: Decodable {
    var label: String
}

struct ContentModel: Decodable {
    var label: String
}

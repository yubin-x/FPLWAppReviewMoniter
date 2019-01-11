//
//  ReviewModel.swift
//  Review
//
//  Created by Wenslow on 2019/1/2.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import Foundation

struct ReviewSearchResult: Decodable {
    let feed: FeedModel
}

struct FeedModel: Decodable {
    let entrys: [ReviewModel]
    
    enum CodingKeys: String, CodingKey {
        case entrys = "entry"
    }
}

struct ReviewModel: Decodable {
    let author: AuthorModel
    let rating: RatingModel
    let title: TitleModel
    let content: ContentModel
    
    enum CodingKeys: String, CodingKey {
        case author
        case rating = "im:rating"
        case title
        case content
    }
}

struct AuthorModel: Decodable {
    let name: NameModel
}

struct NameModel: Decodable {
    let label: String
}

struct RatingModel: Decodable {
    let label: String
}

struct TitleModel: Decodable {
    let label: String
}

struct ContentModel: Decodable {
    let label: String
}

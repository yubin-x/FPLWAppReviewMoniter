//
//  ReviewModel.swift
//  Review
//
//  Created by Wenslow on 2019/1/2.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import Foundation

public struct ReviewSearchResult: Decodable {
    public let feed: FeedModel
}

public struct FeedModel: Decodable {
    public let entrys: [ReviewModel]
    
    enum CodingKeys: String, CodingKey {
        case entrys = "entry"
    }
}

public struct ReviewModel: Decodable {
    public let author: AuthorModel
    public let rating: RatingModel
    public let title: TitleModel
    public let content: ContentModel
    
    enum CodingKeys: String, CodingKey {
        case author
        case rating = "im:rating"
        case title
        case content
    }
}

public struct AuthorModel: Decodable {
    let name: NameModel
}

public struct NameModel: Decodable {
    let label: String
}

public struct RatingModel: Decodable {
    let label: String
}

public struct TitleModel: Decodable {
    let label: String
}

public struct ContentModel: Decodable {
    let label: String
}

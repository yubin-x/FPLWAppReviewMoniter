//
//  ReviewSearchResult.swift
//  Review
//
//  Created by Wenslow on 2019/1/2.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import Foundation

public struct ReviewSearchResult: Decodable {
    public let feed: FeedResponse
}

public struct FeedResponse: Decodable {
    public let entrys: [ReviewResponse]
    
    enum CodingKeys: String, CodingKey {
        case entrys = "entry"
    }
}

public struct ReviewResponse: Decodable {
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
    public let name: NameModel
}

public struct NameModel: Decodable {
    public let label: String
}

public struct RatingModel: Decodable {
    public let label: String
}

public struct TitleModel: Decodable {
    public let label: String
}

public struct ContentModel: Decodable {
    public let label: String
}

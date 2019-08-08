//
//  ReviewModel.swift
//  Review
//
//  Created by Wenslow on 2019/1/2.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import Foundation
import AppStoreReviewAPILayer

public struct ReviewModel {
    public let author: String
    public let rating: Double
    public let title: String
    public let content: String
    public let version: String
    
    public init(author: String,
                rating: Double,
                title: String,
                content: String,
                version: String) {
        self.author = author
        self.rating = rating
        self.title = title
        self.content = content
        self.version = version
    }
    
    public init(from reviewResponse: ReviewResponse) {
        self.author = reviewResponse.author.name.label
        if let rating = Double(reviewResponse.rating.label) {
            self.rating = rating
        } else {
            self.rating = 0
        }
        self.title = reviewResponse.title.label
        self.content = reviewResponse.content.label
        self.version = reviewResponse.version.label
    }
}

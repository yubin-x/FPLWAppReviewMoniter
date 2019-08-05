//
//  AppStoreReviewServiceFactory.swift
//  AppStoreReviewService
//
//  Created by 朱廷 on 2019/8/5.
//  Copyright © 2019 朱廷. All rights reserved.
//

import Foundation

public struct AppStoreReviewServiceFactory {
    public static func makeAppSearchService() -> AppSearchServiceLayer {
        return AppSearchService()
    }
    
    public static func makeReviewService() -> ReviewServiceLayer {
        return ReviewService()
    }
}

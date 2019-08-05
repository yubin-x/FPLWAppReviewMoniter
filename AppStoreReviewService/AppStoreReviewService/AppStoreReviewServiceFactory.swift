//
//  AppStoreReviewServiceFactory.swift
//  AppStoreReviewService
//
//  Created by 朱廷 on 2019/8/5.
//  Copyright © 2019 朱廷. All rights reserved.
//

import Foundation

public struct AppStoreReviewServiceFactory {
    public static func makeAppSearchService() -> AppInfoServiceProtocol {
        return AppInfoService()
    }
    
    public static func makeReviewService() -> ReviewServiceProtocol {
        return ReviewService()
    }
}

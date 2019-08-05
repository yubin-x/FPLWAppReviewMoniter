//
//  AppStoreReviewAPILayerFactory.swift
//  AppStoreReviewService
//
//  Created by 朱廷 on 2019/8/5.
//  Copyright © 2019 朱廷. All rights reserved.
//

import Foundation

public struct AppStoreReviewAPILayerFactory {
    public static func makeAppSearchAPILayer() -> AppSearchAPILayer {
        return AppSearchAPIService()
    }
    
    public static func makeReviewAPILayer() -> ReviewAPILayer {
        return ReviewAPIService()
    }
}

//
//  ReviewService.swift
//  Review
//
//  Created by Wenslow on 2019/1/4.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import RxSwift
import AppStoreReviewAPILayer

public protocol ReviewServiceProtocol {
    func fetchReviewData(appID: String, page: Int) -> Observable<Result<[ReviewModel],Error>>
}

class ReviewService: ReviewServiceProtocol {
    
    let reviewAPILayer: ReviewAPILayer
    
    init(reviewAPILayer: ReviewAPILayer = AppStoreReviewAPILayerFactory.makeReviewAPILayer()) {
        self.reviewAPILayer = reviewAPILayer
    }
    
    func fetchReviewData(appID: String, page: Int) -> Observable<Result<[ReviewModel],Error>> {
        return reviewAPILayer.fetchReviewData(appID: appID, page: page).map {
            let reviewModels = $0.map {
                return ReviewModel(from: $0)
            }
            return Result.success(reviewModels)
        }.catchError { return Observable.just(Result.failure($0)) }
    }
}

//
//  ReviewViewModel.swift
//  Review
//
//  Created by Wenslow on 2019/1/2.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import RxSwift
import RxCocoa

protocol BaseReviewViewable {
    var appID: Int64 { set get }
    func fetchReviewData() -> Observable<[ReviewModel]>
}

class BaseReviewViewModel: BaseReviewViewable {
    
    var appID: Int64
    let reviewService: ReviewServiceLayer
    let disposeBag = DisposeBag()
    
    init(appID: Int64 ,
         reviewService: ReviewServiceLayer = ReviewService()) {
        self.appID = appID
        self.reviewService = reviewService
    }
    
    func fetchReviewData() -> Observable<[ReviewModel]> {
        var observerList = [Observable<[ReviewModel]>]()
        
        for i in 1...3 {
            observerList.append(reviewService.fetchReviewData(appID: String(appID), page: i))
        }
        
        /* Zip three API call result to [[EntryModel]] Array */
        return Observable.zip(observerList)
            .map { (result) -> [ReviewModel] in
                var entryModels = [ReviewModel]()
                result.forEach { entryModels.append(contentsOf: $0) }
                return entryModels
            }
    }
}

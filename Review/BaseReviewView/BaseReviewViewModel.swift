//
//  ReviewViewModel.swift
//  Review
//
//  Created by Wenslow on 2019/1/2.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import RxSwift
import RxCocoa
import AppStoreReviewService

protocol BaseReviewViewable {
    var appID: Int { set get }
    func fetchReviewData() -> Observable<[ReviewModel]>
}

class BaseReviewViewModel: BaseReviewViewable {
    
    var appID: Int
    let reviewService: ReviewServiceProtocol
    let disposeBag = DisposeBag()
    
    init(appID: Int,
         reviewService: ReviewServiceProtocol = AppStoreReviewServiceFactory.makeReviewService()) {
        self.appID = appID
        self.reviewService = reviewService
    }
    
    func fetchReviewData() -> Observable<[ReviewModel]> {
        var observerList = [Observable<Result<[ReviewModel], Error>>]()
        
        for i in 1...3 {
            observerList.append(reviewService.fetchReviewData(appID: appID, page: i))
        }
        
        /* Zip three API call result to [[EntryModel]] Array */
        return Observable.zip(observerList)
            .map { (result) -> [ReviewModel] in
                var reviewModels = [ReviewModel]()
                result.forEach {
                    switch $0 {
                    case .success(let values):
                        reviewModels.append(contentsOf: values)
                    case .failure(_):
                        reviewModels.append(contentsOf: [])
                    }
                }
                return reviewModels
            }
    }
}

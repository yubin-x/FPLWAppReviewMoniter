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
    var title: String { get }
    var appModel: AppModel { set get }
    func fetchReviewData() -> Observable<[ReviewModel]>
}

class BaseReviewViewModel: BaseReviewViewable {
    
    var appModel: AppModel
    let reviewService: ReviewServiceLayer
    let disposeBag = DisposeBag()
    
    var title: String {
        return appModel.appName
    }
    
    init(appModel: AppModel,
         reviewService: ReviewServiceLayer = ReviewService()) {
        self.appModel = appModel
        self.reviewService = reviewService
    }
    
    func fetchReviewData() -> Observable<[ReviewModel]> {
        var observerList = [Observable<[ReviewModel]>]()
        
        for i in 1...3 {
            observerList.append(reviewService.fetchReviewData(appID: String(appModel.appId), page: i))
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

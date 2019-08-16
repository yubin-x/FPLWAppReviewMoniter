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
    var appInfoModel: AppInfoModel { get }
    func updateAppInfoModel(appInfoModel: AppInfoModel)
    func fetchReviewData() -> Observable<[ReviewModel]>
}

class BaseReviewViewModel: BaseReviewViewable {
    
    var appInfoModel: AppInfoModel
    let reviewService: ReviewServiceProtocol
    let disposeBag = DisposeBag()
    
    let errorReplay = BehaviorRelay<Bool>(value: false)
    
    var errorObserver: Observable<Bool> {
        return errorReplay.asObservable()
    }
    
    init(appInfoModel: AppInfoModel,
         reviewService: ReviewServiceProtocol = AppStoreReviewServiceFactory.makeReviewService()) {
        self.appInfoModel = appInfoModel
        self.reviewService = reviewService
    }
    
    func updateAppInfoModel(appInfoModel: AppInfoModel) {
        self.appInfoModel = appInfoModel
    }
    
    func fetchReviewData() -> Observable<[ReviewModel]> {
        var observerList = [Observable<Result<[ReviewModel], Error>>]()
        
        for i in 1...3 {
            observerList.append(reviewService.fetchReviewData(appInfoModel: appInfoModel, page: i))
        }
        
        /* Zip three API call result to [[EntryModel]] Array */
        return Observable.zip(observerList)
            .map { [weak self] (result) -> [ReviewModel] in
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

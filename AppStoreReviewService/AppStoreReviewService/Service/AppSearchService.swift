//
//  AppInfoService.swift
//  Review
//
//  Created by Wenslow on 2019/1/11.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import RxSwift
import AppStoreReviewAPILayer
import ReviewHelperKit

public protocol AppInfoServiceProtocol {
    func searchApp(term: String, country: Country) -> Observable<Result<[AppInfoModel], Error>>
}

class AppInfoService: AppInfoServiceProtocol {
    
    let appSearchAPILayer: AppSearchAPILayer
    
    init(appSearchAPILayer: AppSearchAPILayer = AppStoreReviewAPILayerFactory.makeAppSearchAPILayer()) {
        self.appSearchAPILayer = appSearchAPILayer
    }
    
    func searchApp(term: String, country: Country) -> Observable<Result<[AppInfoModel], Error>> {
        return appSearchAPILayer.searchApp(term: term, country: country).map {
            let appModels = $0.map({ (response) -> AppInfoModel in
                return AppInfoModel(from: response)
            })
            return Result.success(appModels)
        }.catchError { return Observable.just(Result.failure($0)) }
    }
}

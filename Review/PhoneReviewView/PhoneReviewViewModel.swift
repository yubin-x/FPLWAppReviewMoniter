//
//  PhoneReviewViewModel.swift
//  Review
//
//  Created by 朱廷 on 2019/8/6.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import RxCocoa
import RxSwift
import AppStoreReviewService

protocol PhoneReviewViewable {
    var title: String { get }
//    var fetchAppResult: BehaviorRelay<AppInfoModel?> { get }
    func fetchApp(appID: Int) -> Observable<AppInfoModel?>
}

class PhoneReviewViewModel: PhoneReviewViewable {
    
//    let fetchAppResult = BehaviorRelay<AppInfoModel?>(value: nil)
    let disposeBag = DisposeBag()
    
    let appInfoService: AppInfoServiceProtocol
    
    var title: String {
        return "App List"
    }
    
    init(appInfoService: AppInfoServiceProtocol = AppStoreReviewServiceFactory.makeAppSearchService()) {
        self.appInfoService = appInfoService
    }
    
    func fetchApp(appID: Int) -> Observable<AppInfoModel?> {
        return appInfoService.fetchApp(appID: appID)
            .map { result in
                switch result {
                case .success(let value):
                    return value
                case .failure(let error):
                    print(error)
                    return nil
                }
        }
    }
}


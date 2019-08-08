//
//  AppSearchViewModel.swift
//  Review
//
//  Created by Wenslow on 2019/1/11.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import RxSwift
import RxCocoa
import AppStoreReviewService
import ReviewHelperKit

protocol AppSearchViewable {
    var saveAppSuccess: Observable<Bool> { get }
    func saveApp(appInfoModel: AppInfoModel)
    func searchApp(term: String) -> Observable<[AppInfoModel]>
}

class AppSearchViewModel: AppSearchViewable {
    
    let saveAppSuccessReplay = BehaviorRelay<Bool>(value: false)
    let disposeBag = DisposeBag()
    
    let searchService: AppInfoServiceProtocol
    
    var saveAppSuccess: Observable<Bool> {
        return saveAppSuccessReplay.asObservable()
    }
    
    init(searchService: AppInfoServiceProtocol = AppStoreReviewServiceFactory.makeAppSearchService()) {
        self.searchService = searchService
    }
    
    func saveApp(appInfoModel: AppInfoModel) {
        guard !ConfigurationProvidor.savedAppIDs.contains(appInfoModel.appId) else {
            saveAppSuccessReplay.accept(false)
            return
        }
        searchService.saveApp(data: appInfoModel)
            .subscribe(onNext: { [weak self] (result) in
                switch result {
                case .success(_):
                    self?.saveAppSuccessReplay.accept(true)
                case .failure(_):
                    self?.saveAppSuccessReplay.accept(false)
                }
            }).disposed(by: disposeBag)
    }
    
    func searchApp(term: String) -> Observable<[AppInfoModel]> {
        return searchService.searchApp(term: term).map {
            switch $0 {
            case .success(let value):
                return value
            case .failure(_):
                return []
            }
        }
    }
}

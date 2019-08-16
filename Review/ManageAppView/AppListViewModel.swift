//
//  AppListViewModel.swift
//  Review
//
//  Created by Wenslow on 2019/1/12.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import RxCocoa
import RxSwift
import AppStoreReviewService
import ReviewHelperKit

protocol AppListViewable {
    var title: String { get }
    var fetchAppResult: Observable<[AppInfoModel]> { get }
    func fetchSavedApps()
    func deleteApp(model: AppInfoModel)
    func selectApp(appInfoModel: AppInfoModel)
}

class AppListViewModel: AppListViewable {
    
    let fetchAppReplay = BehaviorRelay<[AppInfoModel]>(value: [])
    let disposeBag = DisposeBag()
    
    let appInfoProtocol: AppInfoServiceProtocol
    
    var fetchAppResult: Observable<[AppInfoModel]> {
        return fetchAppReplay.asObservable()
    }
    
    var title: String {
        return "App List"
    }
    
    init(appInfoProtocol: AppInfoServiceProtocol = AppStoreReviewServiceFactory.makeAppSearchService()) {
        self.appInfoProtocol = appInfoProtocol
    }
    
    func fetchSavedApps() {
        appInfoProtocol.fetchApps()
            .subscribe(onNext: { [weak self] (result) in
                switch result {
                case .success(let value):
                    self?.fetchAppReplay.accept(value)
                case .failure(_):
                    self?.fetchAppReplay.accept([])
                }
        }).disposed(by: disposeBag)
    }
    
    func deleteApp(model: AppInfoModel) {
        guard let index = fetchAppReplay.value.firstIndex(where: {
            return model.appId == $0.appId
        }) else { return }

        appInfoProtocol.deleteApp(appID: model.appId)
            .subscribe(onNext: { (result) in
                switch result {
                case .success(let value):
                    guard value else { return }
                    var apps = self.fetchAppReplay.value
                    apps.remove(at: index)
                    self.fetchAppReplay.accept(apps)
                    if ConfigurationProvidor.savedAppID == model.appId {
                        if let newAppID = apps.first?.appId {
                            ConfigurationProvidor.savedAppID = newAppID
                        } else {
                            ConfigurationProvidor.savedAppID = nil
                        }
                    }
                case .failure(_):
                    break
                }
        }).disposed(by: disposeBag)
    }
    
    func selectApp(appInfoModel: AppInfoModel) {
        ConfigurationProvidor.savedAppID = appInfoModel.appId
    }
}

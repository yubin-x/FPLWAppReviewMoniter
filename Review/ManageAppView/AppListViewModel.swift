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
    func deleteApp(indexPath: IndexPath)
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
    
    func deleteApp(indexPath: IndexPath) {
        guard fetchAppReplay.value.count >= indexPath.row else { return }
        let app = fetchAppReplay.value[indexPath.row]
        appInfoProtocol.deleteApp(indexPath: indexPath)
            .subscribe(onNext: { (result) in
                switch result {
                case .success(let value):
                    guard value else { return }
                    if let index = ConfigurationProvidor.savedAppIDs.firstIndex(of: app.appId) {
                        var appIDs = ConfigurationProvidor.savedAppIDs
                        appIDs.remove(at: index)
                        ConfigurationProvidor.savedAppIDs = appIDs
                    }
                    var apps = self.fetchAppReplay.value
                    apps.remove(at: indexPath.row)
                    self.fetchAppReplay.accept(apps)
                case .failure(_):
                    break
                }
        }).disposed(by: disposeBag)
    }
    
    func selectApp(appInfoModel: AppInfoModel) {
        var appIDs = ConfigurationProvidor.savedAppIDs
        if let index = appIDs.firstIndex(of: appInfoModel.appId) {
            appIDs.remove(at: index)
            appIDs.insert(appInfoModel.appId, at: 0)
            ConfigurationProvidor.savedAppIDs = appIDs
        }
    }
}

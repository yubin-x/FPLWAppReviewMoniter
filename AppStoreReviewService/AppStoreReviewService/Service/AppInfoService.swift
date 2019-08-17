//
//  AppSearchService.swift
//  Review
//
//  Created by Wenslow on 2019/1/11.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import RxSwift
import AppStoreReviewAPILayer
import ReviewHelperKit
import CacheKit

public enum AppInfoServiceError: Error {
    case findAppFail
    case coreStoreError(Error)
    case duplicateMonitorApp

    public static func generateFrom(appDataEntryError: AppDataEntryError) -> AppInfoServiceError {
        switch appDataEntryError {
        case .coreStoreError(let error):
            return AppInfoServiceError.coreStoreError(error)
        default:
            return AppInfoServiceError.findAppFail
        }
    }
}

public protocol AppInfoServiceProtocol {
    func searchApp(term: String) -> Observable<Result<[AppInfoModel], Error>>
    func fetchApp(appID: Int) -> Observable<Result<AppInfoModel?, AppInfoServiceError>>
    func fetchApps() -> Observable<Result<[AppInfoModel], AppInfoServiceError>>
    func saveApp(data: AppInfoModel) -> Observable<Result<Bool, AppInfoServiceError>>
    func deleteApp(appID: Int) -> Observable<Result<Bool, AppInfoServiceError>>
}

class AppInfoService: AppInfoServiceProtocol {
    
    let appSearchAPILayer: AppSearchAPILayer
    let appInfoCacheManager: AppInfoCacheProtocol
    
    init(appSearchAPILayer: AppSearchAPILayer = AppStoreReviewAPILayerFactory.makeAppSearchAPILayer(),
         appInfoCacheManager: AppInfoCacheProtocol = CacheKitFactory.makeAppInfoCacheManager()) {
        self.appSearchAPILayer = appSearchAPILayer
        self.appInfoCacheManager = appInfoCacheManager
    }
    
    func searchApp(term: String) -> Observable<Result<[AppInfoModel], Error>> {
        return appSearchAPILayer.searchApp(term: term, country: ConfigurationProvidor.currentCountry).map {
            let appModels = $0.map({ (response) -> AppInfoModel in
                return AppInfoModel(from: response)
            })
            return Result.success(appModels)
        }.catchError { return Observable.just(Result.failure($0)) }
    }
    
    func fetchApp(appID: Int) -> Observable<Result<AppInfoModel?, AppInfoServiceError>> {
        return appInfoCacheManager.fetchApp(appID: Int64(appID)).map {
            let newResult = $0
                .map { appSearchResponse -> AppInfoModel? in
                    guard let app = appSearchResponse else { return nil }
                    return AppInfoModel(from: app)
                }
                .mapError({ (error) -> AppInfoServiceError in
                    return AppInfoServiceError.generateFrom(appDataEntryError: error)
                })
            return newResult
        }
    }
    
    func fetchApps() -> Observable<Result<[AppInfoModel], AppInfoServiceError>> {
        return appInfoCacheManager.fetchApps().map {
            let newResult = $0
                .map { appDataEntrys -> [AppInfoModel] in
                    guard let app = appDataEntrys else { return [] }
                    return app.map { (appDataEntry) -> AppInfoModel in
                        return AppInfoModel(from: appDataEntry)
                    }
                }
                .mapError({ (error) -> AppInfoServiceError in
                    return AppInfoServiceError.generateFrom(appDataEntryError: error)
                })
            return newResult
        }
    }
    
    func saveApp(data: AppInfoModel) -> Observable<Result<Bool, AppInfoServiceError>> {
        return fetchApp(appID: data.appId).flatMap { [weak self] (result) -> Observable<Result<Bool, AppInfoServiceError>> in
            guard let self = self else {
                return Observable<Result<Bool, AppInfoServiceError>>
                    .just(Result<Bool, AppInfoServiceError>
                        .failure(AppInfoServiceError.duplicateMonitorApp))
            }

            switch result {
            case .success(let value):
                if value != nil {
                    return Observable<Result<Bool, AppInfoServiceError>>
                        .just(Result<Bool, AppInfoServiceError>
                            .failure(AppInfoServiceError.duplicateMonitorApp))
                } else {
                    return self.appInfoCacheManager.saveApp(appId: Int64(data.appId),
                                                       appName: data.appName,
                                                       iconURLString: data.iconURLString,
                                                       averageUserRating: data.averageUserRating ?? 0,
                                                       genres: data.genres,
                                                       artistName: data.artistName)
                        .map {
                            let newResult = $0
                                .mapError({ (error) -> AppInfoServiceError in
                                    return AppInfoServiceError.generateFrom(appDataEntryError: error)
                                })
                            return newResult
                    }
                }
            case .failure(let error):
                return Observable<Result<Bool, AppInfoServiceError>>
                    .just(Result<Bool, AppInfoServiceError>
                        .failure(error))
            }
        }
    }
    
    func deleteApp(appID: Int) -> Observable<Result<Bool, AppInfoServiceError>> {
        return appInfoCacheManager.deleteApp(appID: appID).map {
            let newResult = $0
                .mapError({ (error) -> AppInfoServiceError in
                    return AppInfoServiceError.generateFrom(appDataEntryError: error)
                })
            return newResult
        }
    }
}

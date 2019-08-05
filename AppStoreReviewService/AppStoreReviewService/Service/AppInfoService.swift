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
    func searchApp(term: String, country: Country) -> Observable<Result<[AppInfoModel], Error>>
    func fetchApp(appID: Int64) -> Observable<Result<AppInfoModel?, AppInfoServiceError>>
    func fetchApps() -> Observable<Result<[AppInfoModel]?, AppInfoServiceError>>
    func saveApp(data: AppInfoModel) -> Observable<Result<Bool, AppInfoServiceError>>
    func deleteApp(indexPath: IndexPath) -> Observable<Result<Bool, AppInfoServiceError>>
}

class AppInfoService: AppInfoServiceProtocol {
    
    let appSearchAPILayer: AppSearchAPILayer
    let appInfoCacheManager: AppInfoCacheProtocol
    
    init(appSearchAPILayer: AppSearchAPILayer = AppStoreReviewAPILayerFactory.makeAppSearchAPILayer(),
         appInfoCacheManager: AppInfoCacheProtocol = CacheKitFactory.makeAppInfoCacheManager()) {
        self.appSearchAPILayer = appSearchAPILayer
        self.appInfoCacheManager = appInfoCacheManager
    }
    
    func searchApp(term: String, country: Country) -> Observable<Result<[AppInfoModel], Error>> {
        return appSearchAPILayer.searchApp(term: term, country: country).map {
            let appModels = $0.map({ (response) -> AppInfoModel in
                return AppInfoModel(from: response)
            })
            return Result.success(appModels)
        }.catchError { return Observable.just(Result.failure($0)) }
    }
    
    func fetchApp(appID: Int64) -> Observable<Result<AppInfoModel?, AppInfoServiceError>> {
        return appInfoCacheManager.fetchApp(appID: appID).map {
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
    
    func fetchApps() -> Observable<Result<[AppInfoModel]?, AppInfoServiceError>> {
        <#code#>
    }
    
    func saveApp(data: AppInfoModel) -> Observable<Result<Bool, AppInfoServiceError>> {
        <#code#>
    }
    
    func deleteApp(indexPath: IndexPath) -> Observable<Result<Bool, AppInfoServiceError>> {
        <#code#>
    }
}

//
//  AppInfoCacheManager.swift
//  CacheKit
//
//  Created by 朱廷 on 2019/8/5.
//  Copyright © 2019 朱廷. All rights reserved.
//

import RxSwift
import CoreStore
import ReviewHelperKit

public enum AppDataEntryError: Error {
    case findAppFail
    case coreStoreError(Error)
}

public protocol AppInfoCacheProtocol {
    func fetchApp(appID: Int64) -> Observable<Result<AppDataEntry?, AppDataEntryError>>
    func fetchApps() -> Observable<Result<[AppDataEntry]?, AppDataEntryError>>
    func saveApp(appId: Int64, appName: String?, iconURLString: String?, averageUserRating: Double) -> Observable<Result<Bool, AppDataEntryError>>
    func deleteApp(indexPath: IndexPath) -> Observable<Result<Bool, AppDataEntryError>>
}

class AppInfoCacheManager: AppInfoCacheProtocol {
    
    let dataStack: DataStack
    
    init(dataStack: DataStack = DataStack(xcodeModelName: ConfigurationProvidor.ReviewCoreDataEntryKey,
                                          bundle: Bundle(for: AppInfoCacheManager.self))) {
        self.dataStack = dataStack
    
        do {
            try self.dataStack.addStorageAndWait()
        }catch{}
    }
    
    func fetchApp(appID: Int64) -> Observable<Result<AppDataEntry?, AppDataEntryError>> {
        return Observable<Result<AppDataEntry?, AppDataEntryError>>.create({ [weak self] (observer) -> Disposable in
            do {
                let app = try self?.dataStack.fetchOne(From<AppDataEntry>().where(\.appId == appID))
                observer.onNext(Result.success(app))
            } catch {
                observer.onNext(Result.failure(AppDataEntryError.coreStoreError(error)))
            }
            return Disposables.create()
        })
    }
    
    func fetchApps() -> Observable<Result<[AppDataEntry]?, AppDataEntryError>> {
        return Observable<Result<[AppDataEntry]?, AppDataEntryError>>.create({ [weak self] (observer) -> Disposable in
            do {
                let apps = try self?.dataStack.fetchAll(From<AppDataEntry>())
                observer.onNext(Result.success(apps))
            } catch {
                observer.onNext(Result.failure(AppDataEntryError.coreStoreError(error)))
            }
            return Disposables.create()
        })
    }
    
    func saveApp(appId: Int64, appName: String?, iconURLString: String?, averageUserRating: Double) -> Observable<Result<Bool, AppDataEntryError>> {
        return Observable<Result<Bool, AppDataEntryError>>.create({ [weak self] (observer) -> Disposable in
            self?.dataStack.perform(asynchronous: { (transaction) -> Void in
                let app = transaction.create(Into<AppDataEntry>())
                app.appId = appId
                app.appName = appName
                app.iconURLString = iconURLString
                app.averageUserRating = averageUserRating
                app.country = ConfigurationProvidor.currentCountry.rawValue
            }, completion: { (result) -> Void in
                switch result {
                case .success:
                    observer.onNext(Result.success(true))
                case .failure(let error):
                    observer.onNext(Result.failure(AppDataEntryError.coreStoreError(error)))
                }
            })
            
            return Disposables.create()
        })
    }
    
    func deleteApp(indexPath: IndexPath) -> Observable<Result<Bool, AppDataEntryError>> {
        return Observable<Result<Bool, AppDataEntryError>>.create({ [weak self] (observer) -> Disposable in
            do {
                guard let apps = try self?.dataStack.fetchAll(From<AppDataEntry>()),
                    apps.count >= indexPath.row else {
                    observer.onNext(Result.failure(AppDataEntryError.findAppFail))
                    return Disposables.create()
                }
                
                let app = apps[indexPath.row]
                
                self?.dataStack.perform(asynchronous: { (transaction) -> Void in
                    transaction.delete(app)
                }, completion: { (result) -> Void in
                    switch result {
                    case .success:
                        if let index = ConfigurationProvidor.savedAppIDs.firstIndex(of: Int(app.appId)) {
                            var appIDs = ConfigurationProvidor.savedAppIDs
                            appIDs.remove(at: index)
                            ConfigurationProvidor.savedAppIDs = appIDs
                        }
                        observer.onNext(Result.success(true))
                    case .failure(let error):
                        observer.onNext(Result.failure(AppDataEntryError.coreStoreError(error)))
                    }
                })
                
            } catch {
                observer.onNext(Result.failure(AppDataEntryError.coreStoreError(error)))
            }
            return Disposables.create()
        })
    }
}

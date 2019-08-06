//
//  AppListViewModel.swift
//  Review
//
//  Created by Wenslow on 2019/1/12.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import RxCocoa
import RxSwift
import CoreStore

protocol AppListViewable {
    var title: String { get }
    var appDataEntry: BehaviorRelay<[AppDataEntry]> { get }
    func fetchSavedApps()
    func deleteApp(indexPath: IndexPath)
    func selectApp(indexPath: IndexPath)
}

class AppListViewModel: AppListViewable {
    
    let appDataEntry = BehaviorRelay<[AppDataEntry]>(value: [])
    
    let dataStack: DataStack
    
    var title: String {
        return "App List"
    }
    
    init(dataStack: DataStack = DataStack(xcodeModelName: ConfigurationProvidor.ReviewCoreDataEntryKey)) {
        self.dataStack = dataStack
        
        do {
            try self.dataStack.addStorageAndWait()
        }catch{}
    }
    
    func fetchSavedApps() {
        guard let apps = try? self.dataStack.fetchAll(From<AppDataEntry>()) else { return }
        appDataEntry.accept(apps)
        var appIDs = [Int64]()
        apps.forEach { appIDs.append($0.appId) }
//        ConfigurationProvidor.savedAppIDs = appIDs
    }
    
    func deleteApp(indexPath: IndexPath) {
        guard appDataEntry.value.count >= indexPath.row else { return }
        let app = appDataEntry.value[indexPath.row]
        dataStack.perform(asynchronous: { (transaction) -> Void in
            transaction.delete(app)
        }, completion: { [unowned self] (result) -> Void in
            switch result {
            case .success:
//                if let index = ConfigurationProvidor.savedAppIDs.firstIndex(of: app.appId) {
//                    var appIDs = ConfigurationProvidor.savedAppIDs
//                    appIDs.remove(at: index)
//                    ConfigurationProvidor.savedAppIDs = appIDs
//                }
                var apps = self.appDataEntry.value
                apps.remove(at: indexPath.row)
                self.appDataEntry.accept(apps)
            case .failure(let error): print(error)
            }
        })
    }
    
    func selectApp(indexPath: IndexPath) {
        guard appDataEntry.value.count >= indexPath.row else { return }
        let appId = appDataEntry.value[indexPath.row].appId
//        ConfigurationProvidor.savedAppIDs = [appId]
    }
}

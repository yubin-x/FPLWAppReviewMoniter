//
//  AppSearchViewModel.swift
//  Review
//
//  Created by Wenslow on 2019/1/11.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import RxSwift
import RxCocoa
import CoreStore
import ReviewHelperKit

protocol AppSearchViewable {
    var saveAppSuccess: BehaviorRelay<Bool> { get }
    func saveApp(appModel: AppModel)
    func searchApp(term: String) -> Observable<[AppModel]>
}

class AppSearchViewModel: AppSearchViewable {
    
    let saveAppSuccess = BehaviorRelay<Bool>(value: false)
    
    let searchService: AppSearchServiceLayer
    let dataStack: DataStack
    
    init(searchService: AppSearchServiceLayer = AppSearchService(),
         dataStack: DataStack = DataStack(xcodeModelName: ConfigurationProvidor.ReviewCoreDataEntryKey)) {
        self.searchService = searchService
        self.dataStack = dataStack
        
        do {
            try self.dataStack.addStorageAndWait()
        }catch{}
    }
    
    func saveApp(appModel: AppModel) {
        dataStack.perform(asynchronous: { (transaction) -> Void in
            let app = transaction.create(Into<AppDataEntry>())
            app.appId = Int64(appModel.appId)
            app.appName = appModel.appName
            app.iconURLString = appModel.iconURLString
            guard let rating = appModel.averageUserRating else { return }
            app.averageUserRating = rating
        }, completion: { [unowned self] (result) -> Void in
            switch result {
            case .success:
                self.saveAppSuccess.accept(true)
            case .failure(let error): print(error)
            }
        })
    }
    
    func searchApp(term: String) -> Observable<[AppModel]> {
        return searchService.searchApp(term: term, country: .china)
    }
}

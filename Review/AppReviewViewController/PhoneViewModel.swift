//
//  PhoneViewModel.swift
//  Review
//
//  Created by Wenslow on 2019/1/12.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import RxCocoa
import RxSwift
import CoreStore

protocol PhoneViewable {
    var title: String { get }
    var fetchAppResult: BehaviorRelay<AppDataEntry?> { get }
    func fetchApp(appID: Int64)
}

class PhoneViewModel: PhoneViewable {
    
    let fetchAppResult = BehaviorRelay<AppDataEntry?>(value: nil)
    
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
    
    
    func fetchApp(appID: Int64) {
        dataStack.perform(asynchronous: { [unowned self] (transaction) -> Void in
            guard let app = transaction.fetchOne(From<AppDataEntry>().where(\.appId == appID)) else { return }
            self.fetchAppResult.accept(app)
        }, completion: { (result) -> Void in
            switch result {
            case .success:
                print("success")
            case .failure(let error): print(error)
            }
        })
    }
}

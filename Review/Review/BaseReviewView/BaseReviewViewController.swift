//
//  ReviewViewController.swift
//  Review
//
//  Created by Wenslow on 2019/1/2.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SVProgressHUD

class BaseReviewViewController: UIViewController {

    var appID = ""
    
    lazy var viewModel: BaseReviewViewable = {
        return BaseReviewViewModel(appID: appID)
    }()
    
    let disposeBag = DisposeBag()
    
    func fetchData() {
        viewModel.fetchReviewData()
            .asDriver(onErrorJustReturn: [])
            .drive(onNext: { (result) in
                print(result)
            }).disposed(by: disposeBag)
    }
}

//
//  PadReviewViewController.swift
//  Review
//
//  Created by Wenslow on 2019/1/5.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import UIKit
import RxSwift

class PadReviewViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var refreshItem: UIBarButtonItem!
    
//    lazy var fpReviewVC = ViewControllerFactory.makeFPReviewViewController()
//    lazy var lwReviewVC = ViewControllerFactory.makeLWReviewViewController()
//    lazy var bmwReviewVC = ViewControllerFactory.makeBMWReviewViewController()
//    lazy var mmReviewVC = ViewControllerFactory.makeMMReviewViewController()
    
    lazy var vcArray = [BaseReviewViewController]()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
        refreshItem.rx.tap.asObservable()
            .subscribe(onNext: { [unowned self] _ in
                self.vcArray.forEach {
                    $0.refreshData()
                }
            }).disposed(by: disposeBag)
    }
    
    func setUpUI() {
        vcArray.forEach { [unowned self] in
            self.stackView.addArrangedSubview($0.view)
            self.addChild($0)
        }
    }
}

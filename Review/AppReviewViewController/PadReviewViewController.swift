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
    
    lazy var storyBoard = UIStoryboard(name: "Main", bundle: nil)
    lazy var fpReviewVC = storyBoard.instantiateViewController(withIdentifier: "FPReviewViewController") as! FPReviewViewController
    lazy var lwReviewVC = storyBoard.instantiateViewController(withIdentifier: "LWReviewViewController") as! LWReviewViewController
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
        refreshItem.rx.tap.asObservable()
            .subscribe(onNext: { [unowned self] _ in
                self.fpReviewVC.refreshData(tableView: self.fpReviewVC.tableView)
                self.lwReviewVC.refreshData(tableView: self.lwReviewVC.tableView)
            }).disposed(by: disposeBag)
    }
    
    func setUpUI() {
        stackView.addArrangedSubview(fpReviewVC.view)
        stackView.addArrangedSubview(lwReviewVC.view)
        
        addChild(fpReviewVC)
        addChild(lwReviewVC)
    }
}

//
//  FPReviewViewController.swift
//  Review
//
//  Created by Wenslow on 2019/1/4.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import UIKit
import RxSwift

class FPReviewViewController: BaseReviewViewController {

    @IBOutlet weak var refreshBarItem: UIBarButtonItem!
    @IBOutlet weak var tableView: BaseReviewTableView!
    
    override var appID: String {
        get {
            return ConfigurationProvidor.FordPassAppID
        }
        set {}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchReviewData(tableView: tableView)
        
        refreshBarItem.rx.tap.asObservable()
            .subscribe(onNext: { [unowned self] _ in
                self.refreshData(tableView: self.tableView)
            }).disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startTimer(tableView: tableView)
    }
}

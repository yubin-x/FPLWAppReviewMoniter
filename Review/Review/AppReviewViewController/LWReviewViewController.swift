//
//  LWReviewViewController.swift
//  Review
//
//  Created by Wenslow on 2019/1/4.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import UIKit
import RxSwift

class LWReviewViewController: BaseReviewViewController {

    @IBOutlet weak var tableView: BaseReviewTableView!
    @IBOutlet weak var refreshBarItem: UIBarButtonItem!
    
    override var appID: String {
        get {
            return ConfigurationProvidor.LincolnWayAppID
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

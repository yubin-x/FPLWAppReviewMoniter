//
//  LWReviewViewController.swift
//  Review
//
//  Created by Wenslow on 2019/1/4.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LWReviewViewController: BaseReviewViewController {

    @IBOutlet weak var tableView: BaseReviewTableView!
    
    override var appID: String {
        get {
            return "1248039588"
        }
        set {}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchReviewData(tableView: tableView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startTimer(tableView: tableView)
    }
}

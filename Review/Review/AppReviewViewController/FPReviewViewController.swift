//
//  FPReviewViewController.swift
//  Review
//
//  Created by Wenslow on 2019/1/4.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import UIKit

class FPReviewViewController: BaseReviewViewController {

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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startTimer(tableView: tableView)
    }
    
    @IBAction func tapRefreshItem(_ sender: Any) {
        refreshData(tableView: tableView)
    }
}

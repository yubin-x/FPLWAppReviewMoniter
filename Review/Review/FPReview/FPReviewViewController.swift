//
//  FPReviewViewController.swift
//  Review
//
//  Created by Wenslow on 2019/1/2.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import UIKit
import SVProgressHUD

class FPReviewViewController: UIViewController {

    private let viewModel = FPReviewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.fetchData()
        
        viewModel.complete = {
            SVProgressHUD.dismiss()
        }
    }
}

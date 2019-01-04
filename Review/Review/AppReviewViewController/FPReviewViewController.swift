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
            return "1141466520"
        }
        set {}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchReviewData()
            .bind(to: tableView.rx.items(cellIdentifier: "BaseReviewTableViewCell", cellType: BaseReviewTableViewCell.self)) { (_, model, cell) in
                cell.bindData(entryModel: model)
            }.disposed(by: disposeBag)
    }
}

//extension FPReviewViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "BaseReviewTableViewCell", for: indexPath)
//        return cell
//    }
//}

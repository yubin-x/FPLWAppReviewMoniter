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

class BaseReviewViewController: UIViewController {

    var appID = ""
    var timer: Timer!
    var shouldScrollToTop = false
    var lastIndexPath = IndexPath(row: 0, section: 0)
    var lastIndexPathEqualCount = 0
    
    lazy var viewModel: BaseReviewViewable = {
        return BaseReviewViewModel(appID: appID)
    }()
    
    let disposeBag = DisposeBag()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        invalidateTimer()
    }
    
    func fetchReviewData(tableView: UITableView) {
        viewModel.fetchReviewData()
            .bind(to: tableView.rx.items(cellIdentifier: "BaseReviewTableViewCell", cellType: BaseReviewTableViewCell.self)) { (_, model, cell) in
                cell.bindData(entryModel: model)
            }.disposed(by: disposeBag)
    }
    
    func startTimer(tableView: UITableView) {
        timer = Timer(timeInterval: 5, repeats: true) { [unowned self] (_) in
            guard let firstIndexPath = tableView.indexPathsForVisibleRows?.first,
                let lastIndexPath = tableView.indexPathsForVisibleRows?.last else { return }
            
            if self.lastIndexPath == lastIndexPath {
                self.lastIndexPathEqualCount += 1
            }
            
            /* when lastIndexPath stay same for more than ten times,
             it means tableView truely scroll to end */
            
            if self.lastIndexPathEqualCount >= 10 {
                self.shouldScrollToTop = true
                self.lastIndexPathEqualCount = 0
            }
            
            self.lastIndexPath = lastIndexPath
            
            let targetIndexPath: IndexPath
            
            if self.shouldScrollToTop {
                targetIndexPath = IndexPath(row: 0, section: 0)
                self.shouldScrollToTop = false
            } else {
                targetIndexPath = IndexPath(row: firstIndexPath.row + 1, section: 0)
            }
            
            tableView.scrollToRow(at: targetIndexPath, at: .top, animated: true)
        }
        
        RunLoop.current.add(timer, forMode: .default)
    }
    
    func invalidateTimer() {
        guard timer.isValid else { return }
        timer.invalidate()
    }
}

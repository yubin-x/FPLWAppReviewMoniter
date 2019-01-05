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
    
    lazy var indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .gray)
        view.addSubview(indicatorView)
        indicatorView.center = view.center
        indicatorView.hidesWhenStopped = true
        return indicatorView
    }()
    
    var disposeBag = DisposeBag()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        invalidateTimer()
    }
    
    func fetchReviewData(tableView: UITableView) {
        indicatorView.startAnimating()
        
        let observer = viewModel.fetchReviewData().share()
        
        observer
            .bind(to: tableView.rx.items(cellIdentifier: "BaseReviewTableViewCell", cellType: BaseReviewTableViewCell.self)) { (_, model, cell) in
                cell.bindData(entryModel: model)
            }.disposed(by: disposeBag)
        
        observer
            .asObservable()
            .subscribe({ [unowned self] _ in
                self.indicatorView.stopAnimating()
            }).disposed(by: disposeBag)
    }
    
    func refreshData(tableView: UITableView) {
        disposeBag = DisposeBag()
        tableView.setContentOffset(.zero, animated: false)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.fetchReviewData(tableView: tableView)
        }
    }
    
    func startTimer(tableView: UITableView) {
        guard ConfigurationProvidor.enableAutoScroll else { return }
        
        timer = Timer(timeInterval: ConfigurationProvidor.autoScrollTimeInterval,
                      repeats: true) { [unowned self] (_) in
            guard let firstIndexPath = tableView.indexPathsForVisibleRows?.first,
                let lastIndexPath = tableView.indexPathsForVisibleRows?.last else { return }
            
            if self.lastIndexPath == lastIndexPath {
                self.lastIndexPathEqualCount += 1
            } else {
                self.lastIndexPathEqualCount = 0
            }
            
            /* when lastIndexPath stay same for more than ten times,
             it means tableView truely scroll to end */
            
            if self.lastIndexPathEqualCount >= 5 {
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
        guard let timer = timer,
            timer.isValid else { return }
        timer.invalidate()
    }
}

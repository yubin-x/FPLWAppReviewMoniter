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
import SnapKit
import ReviewHelperKit
import AppStoreReviewService

protocol ReviewViewControllerProtocol {
    func setNewApp(appInfoModel: AppInfoModel)
    func refreshData()
}

class BaseReviewViewController: UIViewController, ReviewViewControllerProtocol {

    lazy var tableView = BaseReviewTableView()
    
    var timer: Timer!
    var shouldScrollToTop = false
    var lastIndexPath = IndexPath(row: 0, section: 0)
    var lastIndexPathEqualCount = 0
    let viewModel: BaseReviewViewable
    
    lazy var indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .gray)
        view.addSubview(indicatorView)
        indicatorView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        indicatorView.hidesWhenStopped = true
        return indicatorView
    }()
    
    var disposeBag = DisposeBag()
    
    init(viewModel: BaseReviewViewable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.bottomMargin.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
            make.left.right.equalToSuperview()
        }
        
        fetchReviewData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard !indicatorView.isAnimating else { return }
        startTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        invalidateTimer()
    }
    
    func fetchReviewData() {
        indicatorView.startAnimating()
        
        let observer = viewModel.fetchReviewData().share()
        
        observer
            .bind(to: tableView.rx.items(cellIdentifier: "BaseReviewTableViewCell", cellType: BaseReviewTableViewCell.self)) { (_, model, cell) in
                    cell.bindData(reviewModel: model)
                }.disposed(by: disposeBag)
            
        observer
            .asObservable()
            .subscribe({ [unowned self] _ in
                self.indicatorView.stopAnimating()
                self.startTimer()
            }).disposed(by: disposeBag)
    }
    
    func refreshData() {
        invalidateTimer()
        disposeBag = DisposeBag()
        tableView.setContentOffset(.zero, animated: false)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.fetchReviewData()
        }
    }
    
    func setNewApp(appInfoModel: AppInfoModel) {
        viewModel.updateAppInfoModel(appInfoModel: appInfoModel)
        refreshData()
    }
    
    func startTimer() {
        guard ConfigurationProvidor.enableAutoScroll else { return }
        if timer != nil {
            timer.invalidate()
            timer = nil
        }
        timer = Timer(timeInterval: ConfigurationProvidor.autoScrollTimeInterval,
                      repeats: true) { [unowned self] (_) in
            guard let firstIndexPath = self.tableView.indexPathsForVisibleRows?.first,
                let lastIndexPath = self.tableView.indexPathsForVisibleRows?.last else { return }

            if self.lastIndexPath == lastIndexPath {
                self.lastIndexPathEqualCount += 1
            } else {
                self.lastIndexPathEqualCount = 0
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
                        self.tableView.scrollToRow(at: targetIndexPath, at: .top, animated: true)
        }
        
        RunLoop.current.add(timer, forMode: .default)
    }
    
    func invalidateTimer() {
        guard let timer = timer,
            timer.isValid else { return }
        timer.invalidate()
        self.timer = nil
    }
    
    deinit {
        invalidateTimer()
    }
}

//
//  AppListTableView.swift
//  Review
//
//  Created by Wenslow on 2019/1/11.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import UIKit
import ReviewUIKit
import RxSwift

class AppListTableView: UITableView {
    
    lazy var refresh = UIRefreshControl()
    lazy var activityIndicatorView = UIActivityIndicatorView(style: .large)
    lazy var errorView: IssueBaseView = {
        let view = IssueViews.errorView()
        view.isHidden = true
        return view
    }()
    lazy var noResultView: IssueBaseView = {
        let view = IssueViews.noResultView()
        view.isHidden = true
        return view
    }()
    
    let disposeBag = DisposeBag()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        separatorStyle = .none
        register(AppListTableViewCell.self, forCellReuseIdentifier: "AppListTableViewCell")
        tableFooterView = UIView()
        backgroundColor = ColorKit.backgroundColor.value
        refreshControl = refresh
        
        refresh.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [unowned self] (_) in
                let time = TimeInterval.random(in: 1..<3)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time, execute: {
                    self.refresh.endRefreshing()
                })
        }).disposed(by: disposeBag)


        addSubview(errorView)
        addSubview(noResultView)
        addSubview(activityIndicatorView)
        
        activityIndicatorView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        errorView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 400, height: 470))
        }
        
        noResultView.snp.makeConstraints { (make) in
            make.edges.equalTo(errorView)
        }
    }
    
    func showErrorView() {
        errorView.isHidden = false
        noResultView.isHidden = true
    }
    
    func showNoResultView() {
        errorView.isHidden = true
        noResultView.isHidden = false
    }
    
    func hideIssueView() {
        errorView.isHidden = true
        noResultView.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

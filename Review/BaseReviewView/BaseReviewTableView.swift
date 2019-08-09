//
//  BaseReviewTableView.swift
//  Review
//
//  Created by Wenslow on 2019/1/4.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import UIKit
import ReviewUIKit
import RxSwift

class BaseReviewTableView: UITableView {

    lazy var refresh = UIRefreshControl()
    
    let disposeBag = DisposeBag()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        separatorStyle = .none
        register(BaseReviewTableViewCell.self, forCellReuseIdentifier: "BaseReviewTableViewCell")
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

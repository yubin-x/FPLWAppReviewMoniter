//
//  AppListTableView.swift
//  Review
//
//  Created by Wenslow on 2019/1/11.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import UIKit
import ReviewUIKit

class AppListTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        separatorStyle = .none
        register(AppListTableViewCell.self, forCellReuseIdentifier: "AppListTableViewCell")
        tableFooterView = UIView()
        backgroundColor = ColorKit.backgroundColor.value
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

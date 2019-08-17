//
//  Views.swift
//  ReviewUIKit
//
//  Created by 朱廷 on 2019/8/7.
//  Copyright © 2019 朱廷. All rights reserved.
//

import UIKit
import SnapKit

public struct Views {
    public static func cardContentView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        
        let containerView = UIView()
        containerView.backgroundColor = ColorKit.backgroundColor.value
        containerView.layer.cornerRadius = 8
        containerView.layer.masksToBounds = true
        view.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        return view
    }
    
    public static func seperateView() -> UIView {
        let view = UIView()
        view.backgroundColor = ColorKit.nameLabelColor.value
        view.alpha = 0.3
        return view
    }
}

//
//  PhoneReviewView.swift
//  Review
//
//  Created by tstone10 on 2019/8/6.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import UIKit
import ReviewUIKit

class PhoneReviewView: UIView {

    lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageKit.addAppICONImage.value?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate),
                        for: .normal)
        button.tintColor = ColorKit.midnightBlue.value
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = ColorKit.backgroundColor.value
        
        addSubview(plusButton)
        
        plusButton.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

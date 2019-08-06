//
//  PhoneReviewView.swift
//  Review
//
//  Created by tstone10 on 2019/8/6.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import UIKit

class PhoneReviewView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = ColorKit.backgroundColor.value
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

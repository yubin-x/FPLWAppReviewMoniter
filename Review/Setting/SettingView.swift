//
//  SettingView.swift
//  Review
//
//  Created by tstone10 on 2019/8/6.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import UIKit
import SnapKit

class SettingView: UIView {

    lazy var scrollSwitcherLabel: UILabel = {
        let label = UILabel()
        label.font = FontKit.labelFont.value
        label.text = "Enable Auto Scroll"
        return label
    }()
    lazy var scrollSwitcher: UISwitch = UISwitch()
    lazy var timeIntervalLabel: UILabel = {
        let label = UILabel()
        label.font = FontKit.labelFont.value
        label.text = "Auto Scroll Time Interval"
        return label
    }()
    lazy var timeIntervalTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.textAlignment = .center
        return textField
    }()
    lazy var timeIntervalSubLable: UILabel = {
        let label = UILabel()
        label.text = "Time Interval should be 1 to 20"
        label.font = FontKit.subLabelFont.value
        label.textColor = ColorKit.subLabelTextColor.value
        return label
    }()
    lazy var rightLabel: UILabel = {
        let label = UILabel()
        label.text = "© FordLabs China"
        label.font = FontKit.rightInfoLabelFont.value
        label.textColor = ColorKit.subLabelTextColor.value
        label.textAlignment = .center
        return label
    }()
    lazy var versionLabel: UILabel = {
        let label = UILabel()
        label.font = FontKit.rightInfoLabelFont.value
        label.textColor = ColorKit.subLabelTextColor.value
        label.textAlignment = .center
        return label
    }()

    private let viewMargin: CGFloat = 25
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = ColorKit.backgroundColor.value
        
        addSubview(scrollSwitcher)
        addSubview(scrollSwitcherLabel)
        addSubview(timeIntervalTextField)
        addSubview(timeIntervalLabel)
        addSubview(timeIntervalSubLable)
        addSubview(rightLabel)
        addSubview(versionLabel)
        
        scrollSwitcher.snp.makeConstraints { (make) in
            make.topMargin.equalToSuperview().inset(viewMargin)
            make.right.equalToSuperview().inset(viewMargin)
        }
        scrollSwitcherLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(scrollSwitcher)
            make.left.equalToSuperview().inset(viewMargin)
            make.right.equalTo(scrollSwitcher.snp.left).inset(viewMargin)
        }
        timeIntervalTextField.snp.makeConstraints { (make) in
            make.top.equalTo(scrollSwitcher.snp.bottom).offset(34)
            make.right.equalTo(scrollSwitcher)
            make.size.equalTo(CGSize(width: 51, height: 30))
        }
        timeIntervalLabel.snp.makeConstraints { (make) in
            make.left.equalTo(scrollSwitcherLabel)
            make.right.equalTo(timeIntervalTextField.snp.left).inset(viewMargin)
            make.centerY.equalTo(timeIntervalTextField)
        }
        timeIntervalSubLable.snp.makeConstraints { (make) in
            make.left.equalTo(timeIntervalLabel)
            make.right.equalTo(scrollSwitcher)
            make.top.equalTo(timeIntervalLabel.snp.bottom)
        }
        rightLabel.snp.makeConstraints { (make) in
            make.bottomMargin.equalToSuperview().inset(viewMargin)
            make.left.right.equalToSuperview().inset(viewMargin)
        }
        versionLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(rightLabel.snp.top).offset(-16)
            make.left.right.equalTo(rightLabel)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

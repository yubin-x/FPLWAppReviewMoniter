//
//  SettingView.swift
//  Review
//
//  Created by tstone10 on 2019/8/6.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import UIKit
import SnapKit
import ReviewHelperKit
import RxSwift

class SettingView: UIView {

    let disposeBag = DisposeBag()
    
    lazy var scrollSwitcherLabel: UILabel = {
        let label = UILabel()
        label.font = FontKit.labelFont.value
        label.text = "Enable Auto Scroll"
        return label
    }()
    lazy var scrollSwitcher: UISwitch = {
        let switcher = UISwitch()
        switcher.onTintColor = ColorKit.leafGreen.value
        return switcher
    }()
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
        textField.delegate = self
        return textField
    }()
    lazy var slider: UISlider = {
        let slider = UISlider()
        slider.maximumValue = 20
        slider.minimumValue = 1
        slider.tintColor = ColorKit.electronBlue.value
        return slider
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
    lazy var currentRegionLabel: UILabel = {
        let label = UILabel()
        label.font = FontKit.labelFont.value
        label.text = "Current Region"
        return label
    }()
    lazy var currentRegionValueLabel: UILabel = {
        let label = UILabel()
        label.font = FontKit.labelFont.value
        label.textAlignment = .center
        label.textColor = ColorKit.electronBlue.value
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.layer.borderColor = ColorKit.electronBlue.value?.cgColor
        label.layer.borderWidth = 1
        label.text = ConfigurationProvidor.currentCountry.countryName
        return label
    }()
    lazy var changeRegionButton = UIButton()
    
    private let viewMargin: CGFloat = 25
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUI()
    }
    
    private func configUI() {
        backgroundColor = ColorKit.backgroundColor.value
        
        addSubview(scrollSwitcher)
        addSubview(scrollSwitcherLabel)
        addSubview(timeIntervalTextField)
        addSubview(timeIntervalLabel)
        addSubview(slider)
        addSubview(rightLabel)
        addSubview(versionLabel)
        addSubview(changeRegionButton)
        addSubview(currentRegionLabel)
        addSubview(currentRegionValueLabel)
        
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
        slider.snp.makeConstraints { (make) in
            make.left.equalTo(scrollSwitcherLabel)
            make.right.equalTo(scrollSwitcher)
            make.top.equalTo(timeIntervalLabel.snp.bottom).inset(-20)
        }
        changeRegionButton.snp.makeConstraints { (make) in
            make.top.equalTo(slider.snp.bottom).inset(-34)
            make.left.equalTo(scrollSwitcherLabel)
            make.right.equalTo(scrollSwitcher)
            make.height.equalTo(30)
        }
        currentRegionLabel.snp.makeConstraints { (make) in
            make.top.left.bottom.equalTo(changeRegionButton)
            make.width.equalTo(200)
        }
        currentRegionValueLabel.snp.makeConstraints { (make) in
            make.top.right.bottom.equalTo(changeRegionButton)
            make.width.equalTo(60)
        }
        
        rightLabel.snp.makeConstraints { (make) in
            make.bottomMargin.equalToSuperview().inset(viewMargin)
            make.left.right.equalToSuperview().inset(viewMargin)
        }
        versionLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(rightLabel.snp.top).offset(-16)
            make.left.right.equalTo(rightLabel)
        }
        
        changeRegionButton.rx.tap.subscribe(onNext: { [unowned self] (_) in
            self.showPickerView()
        }).disposed(by: disposeBag)
    }
    
    private func showPickerView() {
        guard !subviews.contains(where: { (view) -> Bool in
            return view.isKind(of: UIPickerView.self)
        }) else { return }
        
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        picker.showsSelectionIndicator = true
        picker.backgroundColor = ColorKit.backgroundColor.value
        addSubview(picker)
        picker.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottomMargin.equalToSuperview().inset(viewMargin)
            make.height.equalTo(200)
        }
        
        if let row = Country.allCountry().firstIndex(where: { (country) -> Bool in
            return country == ConfigurationProvidor.currentCountry }) {
            picker.selectRow(row, inComponent: 0, animated: true)
        }
        
        let tapGesture = UITapGestureRecognizer()
        addGestureRecognizer(tapGesture)
        
        tapGesture.rx.event.bind(onNext: { _ in
            UIView.animate(withDuration: 0.5, animations: {
                picker.alpha = 0
            }, completion: { (_) in
                picker.removeFromSuperview()
            })
        }).disposed(by: disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SettingView: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
}

extension SettingView: UIPickerViewDataSource, UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Country.allCountry().count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Country.allCountry()[row].countryName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentRegionValueLabel.text = Country.allCountry()[row].countryName
        ConfigurationProvidor.currentCountry = Country.allCountry()[row]
    }
}

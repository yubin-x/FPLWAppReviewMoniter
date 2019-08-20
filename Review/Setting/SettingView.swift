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
import ReviewUIKit
import RxSwift

class SettingView: UIView {

    let disposeBag = DisposeBag()
    
    lazy var scrollSwitcherLabel: UILabel = {
        let label = Labels.h1Label()
        label.text = "Enable Auto Scroll"
        return label
    }()
    lazy var scrollSwitcher: UISwitch = {
        let switcher = UISwitch()
        switcher.onTintColor = ColorKit.leafGreen.value
        return switcher
    }()
    lazy var timeIntervalLabel: UILabel = {
        let label = Labels.h1Label()
        label.text = "Auto Scroll Time Interval"
        return label
    }()
    lazy var timeIntervalTextField: UITextField = {
        let textField = TextFields.uneditableTextField()
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
        let label = Labels.appInfoLabel()
        label.text = "© FordLabs China"
        return label
    }()
    lazy var versionLabel: UILabel = Labels.appInfoLabel()
    lazy var currentRegionLabel: UILabel = {
        let label = Labels.h1Label()
        label.text = "Change Country"
        return label
    }()
    lazy var currentRegionValueLabel: UILabel = {
        let label = Labels.countryLabel()
        label.text = ConfigurationProvidor.currentCountry.countryName
        return label
    }()
    lazy var changeRegionButton = UIButton()
    lazy var hiddenTextField: CountrySelectTextField = {
        let textField = CountrySelectTextField()
        textField.pickerView.delegate = self
        textField.pickerView.dataSource = self
        return textField
    }()
    lazy var changeICONLabel: UILabel = {
        let label = Labels.h1Label()
        label.text = "Change App icon"
        return label
    }()
    lazy var currentICONImageView = ImageViews.currentAppICONImageView()
    lazy var changeICONButton = UIButton()

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
        addSubview(hiddenTextField)
        addSubview(changeICONLabel)
        addSubview(changeICONButton)
        addSubview(currentICONImageView)

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
        changeICONButton.snp.makeConstraints { (make) in
            make.top.equalTo(changeRegionButton.snp.bottom).inset(-34)
            make.left.equalTo(scrollSwitcherLabel)
            make.right.equalTo(scrollSwitcher)
            make.height.equalTo(30)
        }
        changeICONLabel.snp.makeConstraints { (make) in
            make.top.left.bottom.equalTo(changeICONButton)
            make.width.equalTo(200)
        }
        currentICONImageView.snp.makeConstraints { (make) in
            make.right.centerY.equalTo(changeICONButton)
            make.size.equalTo(CGSize(width: 30, height: 30))
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
        hiddenTextField.becomeFirstResponder()
        
        if let row = Country.allCountry().firstIndex(where: { (country) -> Bool in
            return country == ConfigurationProvidor.currentCountry }) {
            hiddenTextField.pickerView.selectRow(row, inComponent: 0, animated: true)
        }
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

extension SettingView: ChangeAPPICONViewDelegate {
    func didChangeAppICON() {
        currentICONImageView.image = ImageKit.currentAppICON()
    }
}

//
//  SettingViewController.swift
//  Review
//
//  Created by Wenslow on 2019/1/5.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ReviewHelperKit

class SettingViewController: UIViewController {

    lazy var rootView = SettingView()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = rootView
        title = "Setting"
        
        setupUI()
        bindUI()
    }
    
    func setupUI() {
        rootView.scrollSwitcher.isOn = ConfigurationProvidor.enableAutoScroll
        rootView.timeIntervalTextField.text = String(ConfigurationProvidor.autoScrollTimeInterval)
        rootView.slider.value = Float(ConfigurationProvidor.autoScrollTimeInterval)
        guard let versionNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String else { return }
        
        rootView.versionLabel.text = "Version: " + versionNumber
    }
    
    func bindUI() {
        let tapGesture = UITapGestureRecognizer()
        view.addGestureRecognizer(tapGesture)
        
        tapGesture.rx.event.bind(onNext: { [unowned self] _ in
            self.rootView.timeIntervalTextField.resignFirstResponder()
        }).disposed(by: disposeBag)
        
        rootView.scrollSwitcher.rx.isOn.asObservable()
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { (value) in
                ConfigurationProvidor.enableAutoScroll = value
            }).disposed(by: disposeBag)
        
        rootView.slider.rx.value
            .subscribe(onNext: { [unowned self] value in
                self.rootView.timeIntervalTextField.text = String(format: "%0.1f", value)
                ConfigurationProvidor.autoScrollTimeInterval = TimeInterval(value)
            })
            .disposed(by: disposeBag)
    }
}

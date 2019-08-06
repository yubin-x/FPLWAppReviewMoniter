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

class SettingViewController: UIViewController {

    lazy var rootView = SettingView()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = rootView
        title = "Setting"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupUI()
        bindUI()
    }
    
    func setupUI() {
        rootView.scrollSwitcher.isOn = ConfigurationProvidor.enableAutoScroll
        rootView.timeIntervalTextField.text = String(ConfigurationProvidor.autoScrollTimeInterval)
        
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
        
        rootView.timeIntervalTextField.rx.controlEvent([.editingDidEnd])
            .asObservable()
            .subscribe(onNext: { [unowned self] _ in
                let newTimeInterval: TimeInterval
                
                if let value = self.rootView.timeIntervalTextField.text,
                    let timeInterval = Double(value),
                    timeInterval >= 1 && timeInterval <= 20 {
                    newTimeInterval = timeInterval
                } else {
                    newTimeInterval = 5
                    self.rootView.timeIntervalTextField.text = "5"
                }
                ConfigurationProvidor.autoScrollTimeInterval = newTimeInterval
            })
            .disposed(by: disposeBag)
    }
}

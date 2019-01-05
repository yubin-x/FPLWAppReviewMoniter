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

    @IBOutlet weak var scrollSwitcher: UISwitch!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var versionLabel: UILabel!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindUI()
    }
    
    func setupUI() {
        scrollSwitcher.isOn = ConfigurationProvidor.enableAutoScroll
        textField.text = String(ConfigurationProvidor.autoScrollTimeInterval)
        
        guard let versionNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String else { return }
        
        versionLabel.text = "Version: " + versionNumber
    }
    
    func bindUI() {
        let tapGesture = UITapGestureRecognizer()
        view.addGestureRecognizer(tapGesture)
        
        tapGesture.rx.event.bind(onNext: { [unowned self] _ in
            
            self.textField.resignFirstResponder()
            
            let newTimeInterval: TimeInterval
            
            if let value = self.textField.text,
                let timeInterval = Double(value),
                timeInterval >= 1 && timeInterval <= 20 {
                newTimeInterval = timeInterval
            } else {
                newTimeInterval = 5
                self.textField.text = "5"
            }
            ConfigurationProvidor.autoScrollTimeInterval = newTimeInterval
        }).disposed(by: disposeBag)
        
        scrollSwitcher.rx.isOn.asObservable()
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { (value) in
                ConfigurationProvidor.enableAutoScroll = value
            }).disposed(by: disposeBag)
        
        
    }
}

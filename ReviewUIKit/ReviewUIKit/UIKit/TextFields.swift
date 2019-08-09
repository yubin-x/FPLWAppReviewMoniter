//
//  TextField.swift
//  ReviewUIKit
//
//  Created by 朱廷 on 2019/8/7.
//  Copyright © 2019 朱廷. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

public struct TextFields {
    public static func uneditableTextField() -> UITextField {
        let textField = UITextField()
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.textAlignment = .center
        return textField
    }
}

public class CountrySelectTextField: UITextField {
    
    public lazy var pickerView = PickerView.countryPickerView()
    private let doneBarItem = BarButtonItems.doneItem()
    
    let disposeBag = DisposeBag()
    
    lazy var toolBar: UIToolbar = {
        let toolBar = UIToolbar()
        toolBar.autoresizingMask = UIView.AutoresizingMask.flexibleHeight
        toolBar.items = [BarButtonItems.flexibleSpaceItem(), doneBarItem]
        toolBar.barTintColor = ColorKit.backgroundColor.value
        toolBar.backgroundColor = ColorKit.backgroundColor.value
        return toolBar
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        inputView = pickerView
        inputAccessoryView = toolBar
        
        doneBarItem.rx.tap.subscribe(onNext: { [unowned self] (_) in
            self.resignFirstResponder()
        }).disposed(by: disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

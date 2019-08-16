//
//  ChangeAPPICONView.swift
//  ReviewUIKit
//
//  Created by tstone10 on 2019/8/16.
//  Copyright © 2019 朱廷. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit
import ReviewHelperKit

public protocol ChangeAPPICONViewDelegate: class {
    func didChangeAppICON()
}

public class ChangeAPPICONView: UIView {

    let disposeBag = DisposeBag()

    public weak var delegate: ChangeAPPICONViewDelegate?

    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.alpha = 0.7
        return view
    }()
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorKit.backgroundColor.value
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()
    lazy var iconImageButton1: UIButton = {
        let button = Buttons.appICONButton()
        button.setImage(ImageKit.primaryImage.value, for: UIControl.State.normal)
        button.setImage(ImageKit.primaryImage.value, for: UIControl.State.highlighted)
        return button
    }()
    lazy var iconImageButton2: UIButton = {
        let button = Buttons.appICONButton()
        button.setImage(ImageKit.secondImage.value, for: UIControl.State.normal)
        button.setImage(ImageKit.secondImage.value, for: UIControl.State.highlighted)
        return button
    }()
    lazy var iconImageButton3: UIButton = {
        let button = Buttons.appICONButton()
        button.setImage(ImageKit.thirdImage.value, for: UIControl.State.normal)
        button.setImage(ImageKit.thirdImage.value, for: UIControl.State.highlighted)
        return button
    }()
    lazy var iconImageButtonArray = [iconImageButton1, iconImageButton2, iconImageButton3]
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: iconImageButtonArray)
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.fillEqually
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configUI()
        animation()
        setBorderColor(index: AppICONType.currentTypeInde())
    }

    func configUI() {
        addSubview(backgroundView)
        addSubview(containerView)
        containerView.addSubview(stackView)

        backgroundView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        containerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(250)
        }
        stackView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(200)
        }
    }

    func animation() {
        let tap = UITapGestureRecognizer()
        backgroundView.addGestureRecognizer(tap)
        tap.rx.event.subscribe(onNext: { [unowned self] (_) in
            self.dismissAnimation()
        }).disposed(by: disposeBag)

        UIView.animate(withDuration: 0.5,
                       delay: 0.3,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 15,
                       options: UIView.AnimationOptions.curveEaseOut,
                       animations: { [unowned self] in
                        self.containerView.snp.updateConstraints({ (make) in
                            make.top.equalTo(self.snp.bottom).inset(200)
                        })
                        self.layoutIfNeeded()
            }, completion: nil)
    }

    func setBorderColor(index: Int) {
        for i in 0..<iconImageButtonArray.count {
            if i == index {
                iconImageButtonArray[i].imageView?.layer.borderColor = ColorKit.leafGreen.value?.cgColor
                continue
            } else {
                iconImageButtonArray[i].imageView?.layer.borderColor = UIColor.clear.cgColor
            }

            iconImageButtonArray[i].rx.tap.asObservable()
                .subscribe(onNext: { [unowned self] (_) in
                    AppICONChangeHelper.setAppICON(index: i)
                    self.delegate?.didChangeAppICON()
                    self.dismissAnimation()
                }).disposed(by: disposeBag)
        }
    }

    func dismissAnimation() {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }, completion: { (_) in
            self.removeFromSuperview()
        })
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

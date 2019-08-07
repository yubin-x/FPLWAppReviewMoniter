//
//  PhoneReviewViewController.swift
//  Review
//
//  Created by tstone10 on 2019/8/6.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import ReviewHelperKit

class PhoneReviewViewController: UIViewController {
    
    lazy var rootView = PhoneReviewView()
    
    let viewModel: PhoneReviewViewable
    
    let disposeBag = DisposeBag()
    
    var reviewVC: (UIViewController & ReviewViewControllerProtocol)!
    var currentAppID: Int?
    
    init(viewModel: PhoneReviewViewable = PhoneReviewViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = rootView
        
        setNavigationBar()
//        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refreshUI()
    }
    
    private func setNavigationBar() {
        let leftBarButton = UIBarButtonItem(image: ImageKit.menuICONImage.value,
                                            style: UIBarButtonItem.Style.plain,
                                            target: nil,
                                            action: nil)
        
        let rightBarButton = UIBarButtonItem(image: ImageKit.refreshICONImage.value,
                                             style: UIBarButtonItem.Style.plain,
                                             target: nil,
                                             action: nil)
        
        leftBarButton.rx.tap.subscribe(onNext: { (_) in
            
        }).disposed(by: disposeBag)
        
        rightBarButton.rx.tap.subscribe(onNext: { [unowned self] (_) in
            self.refreshUI()
        }).disposed(by: disposeBag)
        
        
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    
    func refreshUI() {
        let appID = ConfigurationProvidor.savedAppIDs.first
        rootView.plusButton.isHidden = appID != nil
        
        if let vc = reviewVC {
            vc.view.isHidden = appID == nil
            
            if appID == nil {
                title = nil
                reviewVC.view.removeFromSuperview()
                reviewVC.removeFromParent()
            }
        }
        
        guard let id = appID,
            currentAppID != id else { return }
        currentAppID = id
        
        viewModel.fetchApp(appID: id)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] in
                guard let app = $0 else { return }
                self.title = app.appName
                if self.reviewVC == nil {
                    self.setCurrentVC(appID: app.appId)
                } else {
                    self.reviewVC.setNewApp(appID: app.appId)
                }
            }).disposed(by: disposeBag)
    }
    
    func setCurrentVC(appID: Int) {
        reviewVC = ViewControllerFactory.makeBaseReviewViewController(appID: appID)
        rootView.addSubview(reviewVC.view)
        reviewVC.view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        addChild(reviewVC)
    }
    
//    func bindViewModel() {
//        viewModel.fetchAppResult
//            .observeOn(MainScheduler.instance)
//            .subscribe(onNext: { [unowned self] in
//                guard let app = $0 else { return }
//                self.title = app.appName
//                if self.reviewVC == nil {
//                    self.setCurrentVC(appID: app.appId)
//                } else {
//                    self.reviewVC.setNewApp(appID: app.appId)
//                }
//            }).disposed(by: disposeBag)
//    }
}

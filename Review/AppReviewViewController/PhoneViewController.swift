//
//  PhoneViewController.swift
//  Review
//
//  Created by Wenslow on 2019/1/8.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PhoneViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var plusButton: UIButton!
    
    var reviewVC: (UIViewController & ReviewViewControllerProtocol)!
    var currentAppID: Int64?
    
    lazy var viewModel: PhoneViewable = PhoneViewModel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refreshUI()
    }
    
    func refreshUI() {
        let appID = ConfigurationProvidor.savedAppIDs.first
        plusButton.isHidden = appID != nil
        
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
    }
    
    func setCurrentVC(appID: Int64) {
        reviewVC = ViewControllerFactory.makeBaseReviewViewController(appID: appID)
        stackView.addArrangedSubview(reviewVC.view)
        addChild(reviewVC)
    }
    
    func bindViewModel() {
        viewModel.fetchAppResult
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
    
    @IBAction func tabActionBarItem(_ sender: Any) {
        presentAppListViewController()
    }
    
    @IBAction func tabRefreshBarItem(_ sender: Any) {
        guard let reviewVC = reviewVC else { return }
        reviewVC.refreshData()
    }
    
    @IBAction func touchPlusButton(_ sender: Any) {
        presentAppListViewController()
    }
    
    func presentAppListViewController() {
        let appListVC = ViewControllerFactory.makeAppListViewController()
        present(appListVC, animated: true, completion: nil)
    }
}

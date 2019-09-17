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
import ReviewUIKit
import AppStoreReviewService

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
        bindUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refreshUI()
    }

    private func setNavigationBar() {
        let leftBarButton = BarButtonItems.plainBarButtonItemWith(image: ImageKit.menuICONImage.value)

        leftBarButton.rx.tap.subscribe(onNext: { [unowned self] (_) in
            self.enterAppListVC()
        }).disposed(by: disposeBag)

        navigationItem.leftBarButtonItem = leftBarButton
    }


    func refreshUI() {
        let appID = ConfigurationProvidor.savedAppID
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
                    self.setCurrentVC(appInfoModel: app)
                } else {
                    self.reviewVC.setNewApp(appInfoModel: app)
                }
            }).disposed(by: disposeBag)
    }

    func setCurrentVC(appInfoModel: AppInfoModel) {
        reviewVC = ViewControllerFactory.makeBaseReviewViewController(appInfoModel: appInfoModel)
        rootView.addSubview(reviewVC.view)
        reviewVC.view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        addChild(reviewVC)
    }

    func bindUI() {
        rootView.plusButton.rx.tap
            .subscribe(onNext: { [unowned self] (_) in
                self.enterAppListVC()
            }).disposed(by: disposeBag)
    }

    func enterAppListVC() {
        present(ViewControllerFactory.makeAppListViewController(delegate: self),
                animated: true,
                completion: nil)
    }
}

extension PhoneReviewViewController: AppListViewControllerDelegate {
    func didSelectedApp(appInfoModel: AppInfoModel) {

    }
}

//
//  AppListViewController.swift
//  Review
//
//  Created by Wenslow on 2019/1/11.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ReviewUIKit
import AppStoreReviewService

protocol AppListViewControllerDelegate: class {
    func didSelectedApp(appInfoModel: AppInfoModel)
}

class AppListViewController: UIViewController {
    
    lazy var tableView = AppListTableView()
    
    let viewModel: AppListViewable
    
    let disposeBag = DisposeBag()

    var didEntryAppSearchVC = false
    
    weak var delegate: AppListViewControllerDelegate?
    
    init(viewModel: AppListViewable = AppListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        bindUI()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetchSavedApps()
    }
    
    func setUI() {
        title = viewModel.title
        view = tableView
        
        let closeBarButtonItem = BarButtonItems.plainBarButtonItemWith(title: "Close")
        let plusBarButtonItem = BarButtonItems.systemItemAdd()
        
        closeBarButtonItem.rx.tap.subscribe(onNext: { [unowned self] (_) in
            self.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)
        
        plusBarButtonItem.rx.tap.subscribe(onNext: { [unowned self] (_) in
            self.enterAppSearchVC()
        }).disposed(by: disposeBag)
        
        
        navigationItem.leftBarButtonItem = closeBarButtonItem
        navigationItem.rightBarButtonItem = plusBarButtonItem
    }
    
    func bindUI() {
        tableView.rx.itemDeleted
            .subscribe(onNext: { [unowned self] in
                self.viewModel.deleteApp(indexPath: $0)
            }).disposed(by: disposeBag)
        
        tableView.rx.modelSelected(AppInfoModel.self)
            .subscribe(onNext: { [unowned self] (model) in
                self.viewModel.selectApp(appInfoModel: model)
                self.delegate?.didSelectedApp(appInfoModel: model)
                self.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
    }
    
    func bindViewModel() {
        let observer = viewModel.fetchAppResult.share()
        
        observer
            .bind(to: tableView.rx.items(cellIdentifier: "AppListTableViewCell", cellType: AppListTableViewCell.self)) { (_, model, cell) in
                cell.bindData(appModel: model)
            }.disposed(by: disposeBag)
        
        observer
            .subscribe(onNext: { [unowned self] (value) in
                guard value.isEmpty, !self.didEntryAppSearchVC else { return }
                self.didEntryAppSearchVC = true
                self.enterAppSearchVC()
            }).disposed(by: disposeBag)
    }
    
    func enterAppSearchVC() {
        let vc = ViewControllerFactory.makeSearchAppViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

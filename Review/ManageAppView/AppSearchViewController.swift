//
//  AppSearchViewController.swift
//  Review
//
//  Created by Wenslow on 2019/1/11.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import AppStoreReviewService
import ReviewUIKit

class AppSearchViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    let viewMode: AppSearchViewable
    
    lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.dimsBackgroundDuringPresentation = false
        search.searchBar.tintColor = ColorKit.cloudColor.value
        search.searchBar.barTintColor = ColorKit.searchBarColor.value
        tableView.tableHeaderView = search.searchBar
        return search
    }()
    
    lazy var tableView = AppListTableView()
    
    init(viewMode: AppSearchViewable = AppSearchViewModel()) {
        self.viewMode = viewMode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = tableView
        
        bindUI()
        bindViewModel()
        searchController.searchBar.placeholder = "App Name"
        navigationController?.navigationBar.tintColor = ColorKit.cloudColor.value
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        searchController.isActive = false
    }
    
    func bindUI() {
        searchController.searchBar.rx.text
            .orEmpty
            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter { !$0.isEmpty }
            .flatMap {[unowned self] in
                self.viewMode.searchApp(term: $0)
            }
            .bind(to: tableView.rx.items(cellIdentifier: "AppListTableViewCell", cellType: AppListTableViewCell.self)) { (_, model, cell) in
                cell.bindData(appModel: model)
            }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(AppInfoModel.self)
            .subscribe(onNext: { [unowned self] (model) in
                self.saveApp(appModel: model)
            }).disposed(by: disposeBag)
        
        tableView.rx.itemSelected.asObservable()
            .subscribe(onNext: { [unowned self] (indexPath) in
                self.tableView.deselectRow(at: indexPath, animated: true)
            }).disposed(by: disposeBag)
    }
    
    func bindViewModel() {
        viewMode.saveAppSuccess.asObservable()
            .skip(1)
            .subscribe(onNext: { [weak self] (value) in
                guard value else {
                    self?.showDuplicateSaveAppAlert()
                    return
                }
                self?.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
    }

    func saveApp(appModel: AppInfoModel) {
        let ac = AlertHelper.addAppAlert(confirm: { [unowned self] in
            self.viewMode.saveApp(appInfoModel: appModel)
        })
        
        navigationController?.visibleViewController?.present(ac, animated: true, completion: nil)
    }
    
    func showDuplicateSaveAppAlert() {
        let ac = AlertHelper.duplicateAlert()
        navigationController?.visibleViewController?.present(ac, animated: true, completion: nil)
    }
}

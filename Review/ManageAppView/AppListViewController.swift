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

class AppListViewController: UIViewController {
    
    @IBOutlet weak var closeBarItem: UIBarButtonItem!
    @IBOutlet weak var tableView: AppListTableView!
    
    lazy var viewModel: AppListViewable = AppListViewModel()
    
    let disposeBag = DisposeBag()

    var didEntryAppSearchVC = false
    
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
    }
    
    func bindUI() {
        tableView.rx.itemDeleted
            .subscribe(onNext: { [unowned self] in
                self.viewModel.deleteApp(indexPath: $0)
            }).disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [unowned self] in
                self.viewModel.selectApp(indexPath: $0)
                self.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
    }
    
    func bindViewModel() {
        let observer = viewModel.appDataEntry.share()
        
        observer
            .bind(to: tableView.rx.items(cellIdentifier: "AppListTableViewCell", cellType: AppListTableViewCell.self)) { (_, model, cell) in
                cell.bindData(appDataEntry: model)
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
    
    @IBAction func tapCloseBarItem(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapPlusBarItem(_ sender: Any) {
        enterAppSearchVC()
    }
}

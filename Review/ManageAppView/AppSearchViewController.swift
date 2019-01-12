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

class AppSearchViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    lazy var viewMode: AppSearchViewable = {
        return AppSearchViewModel()
    }()
    
    lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.dimsBackgroundDuringPresentation = false
        search.searchBar.tintColor = .black
        tableView.tableHeaderView = search.searchBar
        return search
    }()

    var selectedModel: AppModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindUI()
        searchController.searchBar.placeholder = "App Name"
        navigationController?.navigationBar.tintColor = .black
    }
    

    func bindUI() {
        searchController.searchBar.rx.text
            .orEmpty
            .debounce(1, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter { !$0.isEmpty }
            .flatMap {[unowned self] in
                self.viewMode.searchApp(term: $0)
            }
            .bind(to: tableView.rx.items(cellIdentifier: "AppListTableViewCell", cellType: AppListTableViewCell.self)) { (_, model, cell) in
                cell.bindData(appModel: model)
            }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(AppModel.self)
            .subscribe(onNext: { [unowned self] (model) in
                self.selectedModel = model
                self.saveApp()
            }).disposed(by: disposeBag)
    }

    func saveApp() {
        
        let ac = AlertHelper.addAppAlert(confirm: {
            ConfigurationProvidor.saveApps = [self.selectedModel]
        })
        
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        navigationController?.visibleViewController?.present(ac, animated: true, completion: nil)
    }
}

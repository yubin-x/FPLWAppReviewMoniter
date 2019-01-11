//
//  PhoneViewController.swift
//  Review
//
//  Created by Wenslow on 2019/1/8.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import UIKit

class PhoneViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var plusButton: UIButton!
    
    var reviewVC: (UIViewController & ReviewViewControllerProtocol)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        let app = ConfigurationProvidor.saveApps.first
        plusButton.isHidden = app != nil
        
        guard let appModel = app else { return }
        plusButton.isHidden = true
        setCurrentVC(appModel: appModel)
    }
    
    func setCurrentVC(appModel: AppModel) {
        if reviewVC != nil {
            stackView.removeArrangedSubview(reviewVC.view)
            reviewVC.removeFromParent()
        }
        
        reviewVC = ViewControllerFactory.makeBaseReviewViewController(appModel: appModel)
        stackView.addArrangedSubview(reviewVC.view)
        addChild(reviewVC)
        
        setNavigationBar(appModel: appModel)
    }
    
    func setNavigationBar(appModel: AppModel) {
        guard let appModel = ConfigurationProvidor.saveApps.first else { return }
        title = appModel.appName
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

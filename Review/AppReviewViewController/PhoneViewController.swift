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
    
    var reviewVC: (UIViewController & ReviewViewControllerProtocol)!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setCurrentVC()
    }

    func setNavigationBar() {
        self.title = ConfigurationProvidor.currentApp.appNameString
    }
    
    func setCurrentVC() {
        if reviewVC != nil {
            stackView.removeArrangedSubview(reviewVC.view)
            reviewVC.removeFromParent()
        }
        
        reviewVC = ViewControllerFactory.getCurrentOEMApp()
        stackView.addArrangedSubview(reviewVC.view)
        addChild(reviewVC)
        setNavigationBar()
    }
    
    @IBAction func tabActionBarItem(_ sender: Any) {
        let ac = AlertHelper.chooseOEMAppAlertSheet { [unowned self] in
            self.setCurrentVC()
        }
        present(ac, animated: true, completion: nil)
    }
    
    @IBAction func tabRefreshBarItem(_ sender: Any) {
        reviewVC.refreshData()
    }
}

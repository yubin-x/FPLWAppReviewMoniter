//
//  AppListViewController.swift
//  Review
//
//  Created by Wenslow on 2019/1/11.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import UIKit

class AppListViewController: UIViewController {
    
    @IBOutlet weak var closeBarItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "App List"
        
        if ConfigurationProvidor.saveApps.isEmpty {
            enterAppSearchVC()
        }
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

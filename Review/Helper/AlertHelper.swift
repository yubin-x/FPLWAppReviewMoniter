//
//  UIAlertControllerHelper.swift
//  Review
//
//  Created by Wenslow on 2019/1/8.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import UIKit

struct AlertHelper {

    static func addAppAlert(confirm: (()->())?) -> UIAlertController {
        let ac = UIAlertController(title: "Add this App?", message: nil, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            confirm?()
        }
        
        ac.addAction(confirmAction)
        ac.addAction(makeCancelAction())
        
        return ac
    }
    
    static func makeCancelAction() -> UIAlertAction {
        return UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    }
}

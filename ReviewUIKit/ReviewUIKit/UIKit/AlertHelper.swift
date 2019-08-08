//
//  AlertHelper.swift
//  ReviewUIKit
//
//  Created by 朱廷 on 2019/8/7.
//  Copyright © 2019 朱廷. All rights reserved.
//

import UIKit

public struct AlertHelper {
    public static func duplicateAlert() -> UIAlertController {
        let ac = UIAlertController(title: "Already monitor this App", message: nil, preferredStyle: .alert)
        ac.addAction(makeCancelAction())
        return ac
    }
    
    public static func addAppAlert(confirm: (()->())?) -> UIAlertController {
        let ac = UIAlertController(title: "Monitor this App?", message: nil, preferredStyle: .alert)
        
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

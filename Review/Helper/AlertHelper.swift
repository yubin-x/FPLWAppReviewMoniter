//
//  UIAlertControllerHelper.swift
//  Review
//
//  Created by Wenslow on 2019/1/8.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import UIKit

struct AlertHelper {

    static func chooseOEMAppAlertSheet(actionClosure: (()->())?) -> UIAlertController {
        let ac = UIAlertController(title: "Change OEM App", message: nil, preferredStyle: .actionSheet)
        
        let fordPassAction = makeOEMActions(app: OEMAppName.fordPass) {
            ConfigurationProvidor.currentApp = .fordPass
            actionClosure?()
        }
        let lincolnWayAction = makeOEMActions(app: OEMAppName.lincolnWay) {
            ConfigurationProvidor.currentApp = .lincolnWay
            actionClosure?()
        }
        let bmwConnectedAction = makeOEMActions(app: OEMAppName.bmwConnected) {
            ConfigurationProvidor.currentApp = .bmwConnected
            actionClosure?()
        }
        let mercedesMeAction = makeOEMActions(app: OEMAppName.mercedesMe) {
            ConfigurationProvidor.currentApp = .mercedesMe
            actionClosure?()
        }
        
        switch ConfigurationProvidor.currentApp {
        case .fordPass:
            ac.addAction(lincolnWayAction)
            ac.addAction(bmwConnectedAction)
            ac.addAction(mercedesMeAction)
        case .lincolnWay:
            ac.addAction(fordPassAction)
            ac.addAction(bmwConnectedAction)
            ac.addAction(mercedesMeAction)
        case .bmwConnected:
            ac.addAction(fordPassAction)
            ac.addAction(lincolnWayAction)
            ac.addAction(mercedesMeAction)
        case .mercedesMe:
            ac.addAction(fordPassAction)
            ac.addAction(lincolnWayAction)
            ac.addAction(bmwConnectedAction)
        }
        
        ac.addAction(makeCancelAction())
        
        return ac
    }
    
    static func makeOEMActions(app: OEMAppName, actionClosure: (()->())?) -> UIAlertAction {
        return UIAlertAction(title: app.appNameString, style: .default) { _ in
            actionClosure?()
        }
    }
    
    static func makeCancelAction() -> UIAlertAction {
        return UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    }
}

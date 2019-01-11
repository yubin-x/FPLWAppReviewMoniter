//
//  ViewControllerFactory.swift
//  Review
//
//  Created by Wenslow on 2019/1/8.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import UIKit

struct ViewControllerFactory {
    static let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    
    static func makeIPadTabberVC() -> UIViewController {
        return storyBoard.instantiateViewController(withIdentifier: "iPadTabbarVC")
    }
    
    static func makeIPhoneTabberVC() -> UIViewController {
        return storyBoard.instantiateViewController(withIdentifier: "iPhoneTabbarVC")
    }
    
//    static func makeFPReviewViewController() -> UIViewController & ReviewViewControllerProtocol {
//        return makeBaseReviewViewController(appName: .fordPass)
//    }
//
//    static func makeLWReviewViewController() -> UIViewController & ReviewViewControllerProtocol {
//        return makeBaseReviewViewController(appName: .lincolnWay)
//    }
//
//    static func makeBMWReviewViewController() -> UIViewController & ReviewViewControllerProtocol {
//        return makeBaseReviewViewController(appName: .bmwConnected)
//    }
//
//    static func makeMMReviewViewController() -> UIViewController & ReviewViewControllerProtocol {
//        return makeBaseReviewViewController(appName: .mercedesMe)
//    }
    
    static func makeBaseReviewViewController(appModel: AppModel) -> UIViewController & ReviewViewControllerProtocol {
        let vc = storyBoard.instantiateViewController(withIdentifier: "BaseReviewViewController") as! BaseReviewViewController
        let viewModel = BaseReviewViewModel(appModel: appModel)
        vc.viewModel = viewModel
        return vc
    }
    
//    static func getCurrentOEMApp() -> UIViewController & ReviewViewControllerProtocol {
//        let vc = storyBoard.instantiateViewController(withIdentifier: "BaseReviewViewController") as! BaseReviewViewController
//        vc.appID = ConfigurationProvidor.currentApp.appID
//        return vc
//    }
}

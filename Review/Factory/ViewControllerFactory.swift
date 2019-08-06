//
//  ViewControllerFactory.swift
//  Review
//
//  Created by Wenslow on 2019/1/8.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import UIKit

struct ViewControllerFactory {
    
    static func makePhoneTabBarController() -> UITabBarController {
        return PhoneTabBarController()
    }
    
    static func makePhoneReviewViewController() -> UIViewController {
        return PhoneReviewViewController()
    }
    
    static func makeSettingViewController() -> UIViewController {
        return SettingViewController()
    }
    
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
    
    static func makeBaseReviewViewController(appID: Int) -> UIViewController & ReviewViewControllerProtocol {
        let vc = BaseReviewViewController()
        let viewModel = BaseReviewViewModel(appID: appID)
        vc.viewModel = viewModel
        return vc
    }
    
    static func makeAppListViewController() -> UINavigationController {
        let vc = storyBoard.instantiateViewController(withIdentifier: "AppListViewController") as! AppListViewController
        return UINavigationController(rootViewController: vc)
    }
    
    static func makeSearchAppViewController() -> UIViewController {
        return storyBoard.instantiateViewController(withIdentifier: "AppSearchViewController") as! AppSearchViewController
    }
}

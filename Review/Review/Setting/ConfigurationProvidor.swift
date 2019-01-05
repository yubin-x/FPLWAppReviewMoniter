//
//  ConfigurationProvidor.swift
//  Review
//
//  Created by Wenslow on 2019/1/5.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import Foundation

struct ConfigurationProvidor {
    
    static let FordPassAppID = "1141466520"
    static let LincolnWayAppID = "1248039588"
    
    static let autoScrollTimeIntervalKey = "autoScrollTimeIntervalKey"
    static let enableAutoScrollKey = "enableAutoScrollKey"
    
    static var autoScrollTimeInterval: TimeInterval {
        get {
            return UserDefaults.standard.double(forKey: autoScrollTimeIntervalKey)
        }
        set {
            guard newValue > 1 else { return }
            UserDefaults.standard.set(newValue, forKey: autoScrollTimeIntervalKey)
        }
    }
    
    static var enableAutoScroll: Bool {
        get {
            return UserDefaults.standard.bool(forKey: enableAutoScrollKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: enableAutoScrollKey)
        }
    }
}

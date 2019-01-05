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
    
    private static let autoScrollTimeIntervalKey = "autoScrollTimeIntervalKey"
    private static let enableAutoScrollKey = "enableAutoScrollKey"
    
    static var autoScrollTimeInterval: TimeInterval {
        get {
            return UserDefaults.standard.double(forKey: autoScrollTimeIntervalKey)
        }
        set {
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
    
    static func registerDefaultValue() {
        UserDefaults.standard.register(defaults: [ConfigurationProvidor.autoScrollTimeIntervalKey: 5])
        UserDefaults.standard.register(defaults: [ConfigurationProvidor.enableAutoScrollKey: true])
    }
}

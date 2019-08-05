//
//  ConfigurationProvidor.swift
//  Review
//
//  Created by Wenslow on 2019/1/5.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import Foundation

public enum Country: String {
    case china = "cn"
    case usa = "us"
}

public struct ConfigurationProvidor {
    
    public static let ReviewCoreDataEntryKey = "Review"
    
    private static let autoScrollTimeIntervalKey = "autoScrollTimeIntervalKey"
    private static let enableAutoScrollKey = "enableAutoScrollKey"
    private static let savedAppIDsKeys = "savedAppIDsKeys"
    
    public static var autoScrollTimeInterval: TimeInterval {
        get {
            return UserDefaults.standard.double(forKey: autoScrollTimeIntervalKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: autoScrollTimeIntervalKey)
        }
    }
    
    public static var enableAutoScroll: Bool {
        get {
            return UserDefaults.standard.bool(forKey: enableAutoScrollKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: enableAutoScrollKey)
        }
    }
    
    public static func registerDefaultValue() {
        UserDefaults.standard.register(defaults: [ConfigurationProvidor.autoScrollTimeIntervalKey: 5])
        UserDefaults.standard.register(defaults: [ConfigurationProvidor.enableAutoScrollKey: true])
    }
    
    public static var savedAppIDs: [Int64] {
        get {
            guard let rawValue = UserDefaults.standard.object(forKey: savedAppIDsKeys) as? [Int64] else { return [] }
            return rawValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: savedAppIDsKeys)
        }
    }
}

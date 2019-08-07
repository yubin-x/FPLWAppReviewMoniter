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
    
    public var countryName: String {
        switch self {
        case .china:
            return "China"
        case .usa:
            return "USA"
        }
    }
    
    public static func allCountry() -> [Country] {
        return [.china, .usa]
    }
}

public struct ConfigurationProvidor {
    
    public static let ReviewCoreDataEntryKey = "Review"
    
    private static let autoScrollTimeIntervalKey = "autoScrollTimeIntervalKey"
    private static let enableAutoScrollKey = "enableAutoScrollKey"
    private static let savedAppIDsKey = "savedAppIDsKey"
    private static let currentCountryKey = "currentCountryKey"
    
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
    
    public static var currentCountry: Country {
        get {
            let rawValue = UserDefaults.standard.string(forKey: currentCountryKey) ?? "cn"
            return Country(rawValue: rawValue) ?? Country.china
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: currentCountryKey)
        }
    }
    
    public static func registerDefaultValue() {
        UserDefaults.standard.register(defaults: [ConfigurationProvidor.autoScrollTimeIntervalKey: 5])
        UserDefaults.standard.register(defaults: [ConfigurationProvidor.enableAutoScrollKey: true])
        UserDefaults.standard.register(defaults: [ConfigurationProvidor.currentCountryKey: "cn"])
    }
    
    public static var savedAppIDs: [Int] {
        get {
            guard let rawValue = UserDefaults.standard.object(forKey: savedAppIDsKey) as? [Int] else { return [] }
            return rawValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: savedAppIDsKey)
        }
    }
}

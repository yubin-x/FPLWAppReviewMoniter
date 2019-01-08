//
//  ConfigurationProvidor.swift
//  Review
//
//  Created by Wenslow on 2019/1/5.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import Foundation

enum OEMAppName: String {
    case fordPass = "1141466520"
    case lincolnWay = "1248039588"
    case bmwConnected = "1120208127"
    case mercedesMe = "1317228250"
    
    var appID: String {
        return self.rawValue
    }
    
    var appNameString: String {
        switch self {
        case .fordPass:
            return "Ford Pass"
        case .lincolnWay:
            return "Lincoln Way"
        case .bmwConnected:
            return "BMW Connected"
        case .mercedesMe:
            return "Mercedes me"
        }
    }
}

struct ConfigurationProvidor {
    
    private static let autoScrollTimeIntervalKey = "autoScrollTimeIntervalKey"
    private static let enableAutoScrollKey = "enableAutoScrollKey"
    private static let oemAppNameKey = "oemAppNameNameKey"
    
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
    
    static var currentApp: OEMAppName {
        get {
            guard let rawValue = UserDefaults.standard.object(forKey: oemAppNameKey) as? String,
                let app = OEMAppName(rawValue: rawValue) else { return .fordPass }
            return app
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: oemAppNameKey)
        }
    }
}

//
//  CacheKitFactory.swift
//  CacheKit
//
//  Created by 朱廷 on 2019/8/5.
//  Copyright © 2019 朱廷. All rights reserved.
//

import Foundation

public struct CacheKitFactory {
    public static func makeAppInfoCacheManager() -> AppInfoCacheProtocol {
        return AppInfoCacheManager()
    }
}

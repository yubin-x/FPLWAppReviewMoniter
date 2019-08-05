//
//  InstabugHelper.swift
//  InstabugKit
//
//  Created by 朱廷 on 2019/8/5.
//  Copyright © 2019 朱廷. All rights reserved.
//

import Instabug

public struct InstabugHelper {
    static func beginInstabugWith() {
        Instabug.start(withToken: "cedd60760b8c644c4b49a063e16f9836", invocationEvents: [.shake, .screenshot])
    }
}

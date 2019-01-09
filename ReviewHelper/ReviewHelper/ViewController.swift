//
//  ViewController.swift
//  ReviewHelper
//
//  Created by Wenslow on 2019/1/6.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import Cocoa
import IOKit.pwr_mgt

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        registerSleepNotification()
    }

    func registerSleepNotification() {
        NSWorkspace.shared.notificationCenter.addObserver(forName: NSWorkspace.screensDidSleepNotification, object: nil, queue: OperationQueue.main) { [unowned self] (notification) in
            if self.shouldWakeScreen() {
                self.wakeScreen()
            }
        }
        
        NSWorkspace.shared.notificationCenter.addObserver(forName: NSWorkspace.screensDidWakeNotification, object: nil, queue: OperationQueue.main) { (notification) in
            print("Screen did waked")
        }
    }
    
    func wakeScreen() {
        let assertionName = "Surprise is running" as CFString
        var assertionID = IOPMAssertionID(0)
        IOPMAssertionDeclareUserActivity(assertionName, kIOPMUserActiveLocal, &assertionID);
    }
    
    func shouldWakeScreen() -> Bool {
        let date = Date()
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.hour], from: date)
        guard let hour = comp.hour,
            (9...18).contains(hour) else { return false }
        return true
    }
}

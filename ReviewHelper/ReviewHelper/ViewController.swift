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
            if self.checkWorkingHour() {
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
    
    func checkWorkingHour() -> Bool {
        let date = Date()
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.hour], from: date)
        guard let hour = comp.hour else { return false }
        
        let locale = Locale.current
        let formatter = DateFormatter.dateFormat(fromTemplate: "j", options: 0, locale: locale)
        
        if formatter?.contains("a") == true {
            // 12 小时制
            return twelveHourCondition(date: date, hour: hour)
        } else {
            // 24 小时制
            return twentyFourHourCondition(hour: hour)
        }
    }
    
    func twelveHourCondition(date: Date, hour: Int) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a"
        let currentAMPMFormat = dateFormatter.string(from: date).uppercased()
        
        if currentAMPMFormat == "AM" {
            return hour >= 9
        } else {
            return hour <= 6
        }
    }
    
    func twentyFourHourCondition(hour: Int) -> Bool {
        guard (9...18).contains(hour) else { return false }
        return true
    }
}

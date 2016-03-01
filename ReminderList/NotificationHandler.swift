//
//  NotificationHandler.swift
//  ReminderList
//
//  Created by Intern on 2/29/16.
//  Copyright © 2016 Deepa & Matt. All rights reserved.
//

import Foundation
import UIKit

func scheduleLocalNotification(title: String, description: String, reminderDate: NSDate) {

    // Create reminder by setting a local notification
    let localNotification = UILocalNotification()

    localNotification.alertTitle = title
    localNotification.alertBody = description
    localNotification.alertAction = "Alarm"
    localNotification.fireDate = reminderDate
    localNotification.timeZone = NSTimeZone(name: "EST")
    localNotification.category = "reminderCategory"
    UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
}

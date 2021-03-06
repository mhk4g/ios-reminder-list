//
//  AppDelegate.swift
//  ReminderList
//
//  Created by Intern on 2/20/16.
//  Copyright © 2016 Deepa & Matt. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.

        registerForLocalNotifications()

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // Handle a local notification
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {

        // Show the alert

        let alert = UIAlertController(title: notification.alertTitle, message: notification.alertBody, preferredStyle: .Alert)

        let postponeAction = UIAlertAction(title: "Postpone", style: .Default) {
            UIAlertAction in
            NSLog("POSTPONY")
            let reminderVC = self.window?.rootViewController?.childViewControllers[0] as! ReminderTableViewController
            var correctIndex = 99

            for var index = 0; index < reminderVC.reminders.count; ++index {
                NSLog("Actual: \(notification.alertTitle!) Current: \(reminderVC.reminders[index].title)")
                if (reminderVC.reminders[index].title == notification.alertTitle!) {
                    correctIndex = index
                }
            }

            // Set new NSDate in the reminder item
            let currentReminder = reminderVC.reminders[correctIndex]
            currentReminder.dateActual = currentReminder.dateActual.dateByAddingTimeInterval(60*60)
            reminderVC.reminders[correctIndex] = currentReminder
        
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.timeZone = NSTimeZone(name: "EST")
            dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
            let dateString = dateFormatter.stringFromDate(currentReminder.dateActual) ?? "01-01-2016 17:05:05"
            currentReminder.date = dateString

            // Register a new notification for the updated time
            scheduleLocalNotification(currentReminder.title, description: currentReminder.description, reminderDate: currentReminder.dateActual)

            // Update the data of the TableViewController
            reminderVC.tableView.reloadData()
        }

        let dismissAction = UIAlertAction(title: "Dismiss", style: .Default) {
            UIAlertAction in
            NSLog("DISMISS")
        }

        alert.addAction(postponeAction)
        alert.addAction(dismissAction)

        self.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
    }

    func registerForLocalNotifications() {
        let notificationSettings = UIUserNotificationSettings(forTypes: UIUserNotificationType.Alert, categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
    }

}


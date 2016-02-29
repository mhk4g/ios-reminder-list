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
        UIAlertView(title: notification.alertTitle, message: notification.alertBody, delegate: nil, cancelButtonTitle: "Dismiss").show()
    }

    // Handling a user's response to the alert
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, completionHandler: () -> Void) {
        // Point for handling the local notification Action. Provided alongside creating the notification.
        if identifier == "Dismiss" {
            UIAlertView(title: notification.alertTitle, message: notification.alertBody, delegate: nil, cancelButtonTitle: "Dismiss").show()
        } else if identifier == "Postpone" {
            notification.fireDate = NSDate().dateByAddingTimeInterval(60*5) //FIXME()
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
        }
        completionHandler()
    }

    func registerForLocalNotifications() {

        // Dismiss the alarm
        let reminderActionDismiss = UIMutableUserNotificationAction()
        reminderActionDismiss.identifier = "Dismiss"
        reminderActionDismiss.title = "Dismiss"
        reminderActionDismiss.activationMode = UIUserNotificationActivationMode.Background
        reminderActionDismiss.destructive = false
        reminderActionDismiss.authenticationRequired = false

        // Postpone the alarm by one hour
        let reminderActionPostpone = UIMutableUserNotificationAction()
        reminderActionPostpone.identifier = "Postpone"
        reminderActionPostpone.title = "Postpone"
        reminderActionPostpone.activationMode = UIUserNotificationActivationMode.Background
        reminderActionPostpone.destructive = false
        reminderActionPostpone.authenticationRequired = false

        // Add above to category
        let reminderCategory = UIMutableUserNotificationCategory()
        reminderCategory.identifier = "reminderCategory"
        reminderCategory.setActions([reminderActionDismiss, reminderActionPostpone], forContext: UIUserNotificationActionContext.Default)
        reminderCategory.setActions([reminderActionDismiss, reminderActionPostpone], forContext: UIUserNotificationActionContext.Minimal)

        let notificationSettings = UIUserNotificationSettings(forTypes: UIUserNotificationType.Alert, categories: Set(arrayLiteral: reminderCategory))
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
    }


}


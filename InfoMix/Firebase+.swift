//
//  Firebase+.swift
//  InfoMix
//
//  Created by Damir Asamatdinov on 23/01/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import Firebase
import UIKit

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([[.banner, .sound]])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
}

extension AppDelegate: MessagingDelegate {
    func messaging(
        _ messaging: Messaging,
        didReceiveRegistrationToken fcmToken: String?
    ) {
        let tokenDict = ["token": fcmToken ?? ""]
        if let safeFcmToken = fcmToken {
            if let savedFcmToken = UserDefaults.standard.string(forKey: "fcmToken"){
                if(safeFcmToken != savedFcmToken){
                    UserDefaults.standard.set(safeFcmToken, forKey: "fcmToken")
                    UserDefaults.standard.set(true, forKey: "fcmTokenBool")
                }
            } else {
                UserDefaults.standard.set(safeFcmToken, forKey: "fcmToken")
                UserDefaults.standard.set(true, forKey: "fcmTokenBool")
            }
        }
        
        NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: tokenDict)
    }
}

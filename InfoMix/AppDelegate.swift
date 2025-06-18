//
//  AppDelegate.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 7/14/20.
//  Copyright © 2020 Tuan Truong. All rights reserved.
//

import UIKit
import UserNotifications
import Firebase
import FirebaseMessaging
import netfox
import IQKeyboardManagerSwift
import IQKeyboardToolbarManager

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions) { granted, error in
                guard granted else { return }
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
            }
        
        Messaging.messaging().delegate = self
        NetworkManager.shared = NetworkManager.init(baseUrl: "https://dynamic.infomix.uz/api/v2")
//        NetworkManager.shared = NetworkManager.init(baseUrl: "http://192.168.7.61:8080/api/v2")
        
        IQKeyboardManager.shared.isEnabled = true
        IQKeyboardToolbarManager.shared.isEnabled = true
        if Settings.isTestFlightOrDebug {
            NFX.sharedInstance().start()
        }
        
        return true
    }

    func setupGlobalBackButtonStyle() {
        let appearance = UIBarButtonItem.appearance()
        appearance.setTitleTextAttributes([.foregroundColor: UIColor.clear], for: .normal) // Hide text
        appearance.setTitleTextAttributes([.foregroundColor: UIColor.clear], for: .highlighted)
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        _ = CoreDataManager.shared.saveContext()
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }
}


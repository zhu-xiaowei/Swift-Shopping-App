//
//  AppDelegate.swift
//  ModerneShopping
//
//  Created by Zhu, Xiaowei on 2023/5/24.
//
import Clickstream
import FirebaseCore
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        // init clickstream sdk
        do {
            try ClickstreamAnalytics.initSDK()
            let configuration = try ClickstreamAnalytics.getClickstreamConfiguration()
            configuration.isLogEvents = true
            configuration.isTrackScreenViewEvents = false
        } catch {
            print("Failed to initialize ClickstreamAnalytics with \(error)")
        }
        FirebaseApp.configure()
        return true
    }
}

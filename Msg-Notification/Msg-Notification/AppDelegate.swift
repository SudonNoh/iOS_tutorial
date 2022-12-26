//
//  AppDelegate.swift
//  Msg-Notification
//
//  Created by Sudon Noh on 2022/12/23.
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if #available(iOS 10.0, *) {
            // 사용자의 알림 사용여부 세팅
            let notiCenter = UNUserNotificationCenter.current()
            notiCenter.requestAuthorization(options: [.alert, .badge, .sound]) { (didAllow, e) in }
            // 알림 센터와 관련해서 이벤트가 발생하면 Delegate로 전달받도록 하는 역할
            // 즉, 이벤트 감지 역할을 한다.
            notiCenter.delegate = self
            // 앱 실행 도중에 알림 메시지가 도착하면 userNotificationCenter(_:willPresent:withCompletionHandler:) 메소드가 자동으로 호출
            // 사용자가 알림 메시지를 실제로 클릭하면 userNotificationCenter(_:didReceive:withCompletionHandler:) 메소드가 자동으로 호출
        } else {
            
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // 앱이 실행 도중에 알림 메시지가 도착한 경우에 아래 내용이 출력된다.
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        if notification.request.identifier == "wakeup" {
            let userInfo = notification.request.content.userInfo
            print(userInfo["name"]!)
        }

        completionHandler([.badge, .list, .sound])
    }
    
    // 이 메소드는 실제로 사용자가 알림 메시지를 클릭했을 경우에 실행된다.
    // 알림 메세지의 정보는 response 매개변수에 담긴다.
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == "wakeup" {
            let userInfo = response.notification.request.content.userInfo
            print(userInfo["name"]!)
        }
        
        completionHandler()
    }
    
}


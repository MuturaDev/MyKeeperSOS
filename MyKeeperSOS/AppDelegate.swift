//
//  AppDelegate.swift
//  MyKeeperSOS
//
//  Created by JamesMutura on 08/10/2023.
//

import UIKit
import UserNotifications
import MessageUI

//@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    let displayStatusChanged: CFNotificationCallback = { center, observer, name, object, info in
        let str = name!.rawValue as CFString
        if (str == "com.apple.springboard.lockcomplete" as CFString) {
            let isDisplayStatusLocked = UserDefaults.standard
            isDisplayStatusLocked.set(true, forKey: "isDisplayStatusLocked")
            isDisplayStatusLocked.synchronize()
            // sendSMS()
            
            
            
//            if MFMessageComposeViewController.canSendText() {
//                    let messageComposeViewController = MFMessageComposeViewController()
//                    messageComposeViewController.recipients = ["0715090835"]
//                    messageComposeViewController.body = "fdfdf"
//                    messageComposeViewController.messageComposeDelegate = viewController
//                    viewController.present(messageComposeViewController, animated: true, completion: nil)
//                } else {
//                    print("ERROR: SMS services are not available")
//                }
//            
            //NotificationCenter.default.post(name: Notification.Name.taskAddedNotification, object: "Notification Sent")
            
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if success {
                    print("All set!")
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
            
            let content = UNMutableNotificationContent()
            content.title = "Fall Detected!"
            content.subtitle = "We've detected a fall. Are you okay? Please respond within 5 seconds if you need assistance"
            content.sound = UNNotificationSound.default

            // show this notification five seconds from now
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

            // choose a random identifier
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

            // add our notification request
            UNUserNotificationCenter.current().add(request)
            
            let mPhoneNumber = "0715090835";
            let mMessage = "\(content.title)\(content.subtitle)"
            if let url = URL(string: "sms://" + mPhoneNumber + "&body="+mMessage) {
                UIApplication.shared.open(url)
            }
            
            
        }
    }
    
    // Handle notification when the app is in the foreground
      func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
          // Handle the notification here when the app is in the foreground
          completionHandler([.alert, .sound, .badge])
      }

      // Handle notification click
      func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
          
          let userInfo = response.notification.request.content.userInfo
          let title = response.notification.request.content.title
          let message = response.notification.request.content.body
          
          let mPhoneNumber = "0715090835";
          let mMessage = "\(title)\(message)"
          if let url = URL(string: "sms://" + mPhoneNumber + "&body="+mMessage) {
              UIApplication.shared.open(url)
          }
          completionHandler()
      }
    
    
  
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let isDisplayStatusLocked = UserDefaults.standard
        isDisplayStatusLocked.set(false, forKey: "isDisplayStatusLocked")
        isDisplayStatusLocked.synchronize()
        
        // Darwin Notification
        let cfstr = "com.apple.springboard.lockcomplete" as CFString
        let notificationCenter = CFNotificationCenterGetDarwinNotifyCenter()
        let function = displayStatusChanged
        CFNotificationCenterAddObserver(notificationCenter,
                                        nil,
                                        function,
                                        cfstr,
                                        nil,
                                        .deliverImmediately)
        
      //  UNUserNotificationCenter.current().delegate = self
        
        return true
    }
    
    func applicationWillEnterBackground(_ application: UIApplication) {
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {

    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
        let isDisplayStatusLocked = UserDefaults.standard
        if let lock = isDisplayStatusLocked.value(forKey: "isDisplayStatusLocked"){
            // user locked screen
            if(lock as! Bool){
                
                // do anything you want here
                let exitStr = "Lock Button Pressed!"
                let exitStatus = UserDefaults.standard
                exitStatus.set(exitStr, forKey: "exitStatus")
                exitStatus.synchronize()
                print(exitStr)
                
            }
            else{
                
                // do anything you want here
                let exitStr = "Home Button Pressed!"
                let exitStatus = UserDefaults.standard
                exitStatus.set(exitStr, forKey: "exitStatus")
                exitStatus.synchronize()
                print(exitStr)
            }
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateExitStatus"), object: nil)
    }
    
    
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("Back to foreground.")
        
        //restore lock screen setting
        
        let isDisplayStatusLocked = UserDefaults.standard
        isDisplayStatusLocked.set(false, forKey: "isDisplayStatusLocked")
        isDisplayStatusLocked.synchronize()
        
        
    }
    
    
    func applicationDidBecomeActive(_ application: UIApplication) {

    }
    
    func applicationWillTerminate(_ application: UIApplication) {

    }
    

}




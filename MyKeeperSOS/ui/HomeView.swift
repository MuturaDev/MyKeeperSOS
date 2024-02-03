//
//  HomeView.swift
//  MyKeeperSOS
//
//  Created by JamesMutura on 08/10/2023.
//

import SwiftUI
import UIKit
import UserNotifications
import MessageUI

struct HomeView : View {
    
    @AppStorage("exitStatus") var exitStatus: String = ""
    @StateObject private var viewModel = SettingViewModel()
    @State private var showAlert:Bool = true
    @AppStorage("config_installed") var isConfigInstalled: Bool = false
    
    init(){
        _showAlert = State(initialValue: !isConfigInstalled)
        print(showAlert)
        print(isConfigInstalled)
        print(showAlert)
        
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                Color.white.edgesIgnoringSafeArea(.all)
                VStack {
                    HStack() {
                        Spacer()
                        NavigationLink(
                            destination:
                                SettingView(showAlert: $showAlert)
                                    .environmentObject(viewModel),
                             label: {
                                Image(systemName: "gearshape.fill")
                                    .resizable().scaledToFill()
                                    .frame(width: 30, height: 30).cornerRadius(16)
                                    .foregroundColor(.blue)
                        })
                        
                    }.padding()
                    Image(MY_KEEPER_LOGO)
                        .resizable()
                        .frame(width: 200, height: 150).cornerRadius(16)
                    Text("Connected Security")
                        .modifier(SailecFont(.bold, size: 16))
                    Text("Please press the power button 5 times to send the alert message with your location, the phone will automatically stall for 10 minutes in order to discreetly listen to the danger situation by remote assistance")
                        .padding()
                        .modifier(SailecFont(.regular, size: 14))
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    Spacer()
                    Button("Launch alert") {
                        if let url = URL(string: "shortcuts://run-shortcut?name=MyKeeper%20tolauch") {
                            UIApplication.shared.open(url)
                        }
                     }
                    Spacer()
                    Text("Personal and sentisive data management policy")
                        .modifier(SailecFont(.bold, size: 14))
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                }
            }
//            .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name(rawValue: "updateExitStatus"))) { _ in
//                // Update the view when "updateExitStatus" notification is received
//                self.exitStatus = UserDefaults.standard.string(forKey: "exitStatus") ?? "Unknown"
//                //print("Power button pressed")
//                
//                sendSMS()
//            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Install Configuration"),
                    message: Text("You must install the configuration"),
                    dismissButton: .default(
                        Text("Install"),
                        action: {
                            if let url = URL(string: "https://www.icloud.com/shortcuts/60e1846d16854fe1b3ffc06a28b7a762") {
                                           UIApplication.shared.open(url)
                            }
                            
                            // Set the user default to mark the app as installed
                            UserDefaults.standard.set(true, forKey: "config_installed")
                            UserDefaults.standard.synchronize()
                            print(isConfigInstalled)
                            self.showAlert = false
                        }
                    )
                )
            }
        
        }
    }
    
    func scheduleNotification(title: String, subtitle: String, secondsLater: TimeInterval, isRepeating: Bool) {
           
            // Define the content
                let content = UNMutableNotificationContent()
                content.title = title
                content.subtitle = subtitle
                content.sound = .default
            

            // Create a trigger to display the notification immediately
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

            // Create a unique identifier for the notification
            let identifier = UUID().uuidString

            // Create a notification request
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

            // Add the notification request to the notification center
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error sending notification: \(error.localizedDescription)")
                } else {
                    print("Notification sent successfully!")
                }
            }

            
        }

    
    private func sendSMS() {
            scheduleNotification(title: "Fall Detected!", subtitle: "We've detected a fall. Are you okay? Please respond within 5 seconds if you need assistance", secondsLater: 5, isRepeating: false)
            
        //FIX: USE A DIFFERENT PHONE NUMBER
            let recipients = ["0715090835"] // Replace with the recipient's phone number
            let messageBody = "Fall Detected! We've detected a fall. Are you okay? Please respond within 5 seconds if you need assistance"

            if MFMessageComposeViewController.canSendText() {
               let messageComposeViewController = MFMessageComposeViewController()
               messageComposeViewController.recipients = recipients
               messageComposeViewController.body = messageBody
              //messageComposeViewController.messageComposeDelegate = self

               if let rootViewController = UIApplication.shared.windows.first?.rootViewController {
                   rootViewController.present(messageComposeViewController, animated: true, completion: nil)
               }
           } else {
               print("Device cannot send SMS.")
           }
        }
}

struct HomeView_Preview: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

//
//  NotificationManager.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 26.04.2021.
//

import Foundation
import UserNotifications

class NotificationManager {
    
    static let istance =  NotificationManager() // Singleton
    
    
    
    func requestAuthorization (){
        
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            if let error = error {
                print("ERROR: \(error)")
            } else {
                print("SUCCESS")
            }
        }
        
    }
    
    func scheduleNotification(body: String, id: String, date: Date) {
        
        let content = UNMutableNotificationContent()
        content.body = body
        content.sound = .default
        content.badge = 1
        
        
        
//        func scheduleNotification(title: String, subtitle: String, id: String, date: Date) {
//
//            let content = UNMutableNotificationContent()
//            content.title = title
//            content.subtitle = subtitle
//            content.sound = .default
//            content.badge = 1
        
        
        
        
        // BELİRLİ BİR ARALIK SONRASI - 10dk sonra / yarım saat sonra / 1 saat sonra gibi
        
        // let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10.0, repeats: false)
        
        // CALENDER
//        var dateComponents = DateComponents()
//        dateComponents.hour = 11
//        dateComponents.minute = 31
//        dateComponents.weekday = 1
        
      
//        let new = Calendar.current.date(byAdding: .minute, value: 1, to: date)
//        let newdateComp = Calendar.current.dateComponents([.hour, .minute], from: new!)
        
        
        
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        
        let request = UNNotificationRequest(
            identifier: id,
            content: content,
            trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        
    }
    
    func cancelNotification(idArray: [String]) {
//        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
//        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: idArray)
    }
    
    func cancelAllNotification(){
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
}

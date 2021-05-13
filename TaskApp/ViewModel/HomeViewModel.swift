//
//  HomeViewModel.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 18.04.2021.
//

import SwiftUI
import CoreData
import UIKit
import Combine

class HomeViewModel: ObservableObject {
    
    // MARK: PROPERTIES
    
    @Environment(\.managedObjectContext) var context


    @Published var content = ""
    @Published var date = Date(timeIntervalSinceNow: 3600)
    @Published var completion: Bool = false
    
    // Using for filter tasks via calender
    @Published var filterDate = Date ()
    
    // Storing Update Item
    @Published var updateItem : Task!
    
    // For Newdata sheet...
    @Published var isNewData = false
    
    // For Remind Me Active...
    @Published var isRemindMe = false
    
    // For request notification permission
    @Published var isNotifResponseShow = false
    
    
    
    // MARK: FUNCTIONS
    
    
    // Checking And Updating Date Functions...
    let calender = Calendar.current
    func checkDate() -> String {
        
        if calender.isDateInToday(date) {
            return "1HourLater".localized()
        }else if calender.isDateInTomorrow(date) {
            return "tomorrow".localized()
        } else if calender.isDate(date, inSameDayAs: calender.date(byAdding: .day, value: 2, to: Date())!) {
            return "nextDay".localized()
        } else if calender.isDate(date, inSameDayAs: calender.date(byAdding: .day, value: 7, to: Date())!) {
            return "1WeekLater".localized()
        } else if calender.isDate(date, inSameDayAs: calender.date(byAdding: .day, value: 15, to: Date())!) {
            return "15DaysLater".localized()
        }
        
        else {
            return "Other day"
        }
    }
    
    

    
    
    func checkFilterDate() -> String {
        if calender.isDateInToday(filterDate) {
            return "Bugün"
        }
        else if calender.isDateInTomorrow(filterDate) {
            return "Yarın"
        }
        else if calender.isDateInYesterday(filterDate) {
            return "Dün"
        }
        else {
            return "Other day"
        }
        
    }
    
   
    
    // Update tasks
    func updateDate(value: String){
        
        if value == "1HourLater".localized() {
            date = calender.date(byAdding: .hour, value: 1, to: Date())!
        } else if value == "tomorrow".localized() {
            date = calender.date(byAdding: .day, value: 1, to: Date())!
        } else if value == "nextDay".localized() {
            date = calender.date(byAdding: .day, value: 2, to: Date())!
        } else if value == "1WeekLater".localized() {
            date = calender.date(byAdding: .day, value: 7, to: Date())!
        } else if value == "15DaysLater".localized() {
            date = calender.date(byAdding: .day, value: 15, to: Date())!
        }
        
        
        
        else {
            // do something...
        }
        
    }
    
    // Writing data to coreData
    func writeData(context: NSManagedObjectContext){
        
        // Updating Item...
        if updateItem != nil {
            
            // Means update not create new
            updateItem.date = date
            updateItem.content = content
            updateItem.completion = completion
            updateItem.isRemindMe = isRemindMe
            
            try! context.save()
            
            // removing updatingItem if success
            updateItem = nil
            isNewData.toggle()
            content = ""
            date = Date()
            completion = false
            isRemindMe = false
            return
        }
        
        let newTask = Task(context: context)
        newTask.date = date
        newTask.content = content
        newTask.completion = false
        newTask.isRemindMe = isRemindMe
        
        // saving data
        do{
            try context.save()
            // success means closing view
            isNewData.toggle()
            content = ""
            date = Date()
            completion = false
            isRemindMe = false
            
        } catch {
            print(error.localizedDescription)
        }
    }

    // Edit item
    func editItem(item: Task) {
        
        updateItem = item
        
        date = item.date!
        content = item.content!
        completion = item.completion
        isRemindMe = item.isRemindMe

        
        // togging the newDataView...
        isNewData.toggle()
    }
    
  
    // Default tasks for new users
    func firstTimeAddTasks(context: NSManagedObjectContext){
        
        let newTask1 = Task(context: context)
        newTask1.date = Date(timeIntervalSinceNow: 1)
        newTask1.content = "\("newUserTask1".localized()) 👆🏻"
        newTask1.completion = false
        newTask1.isRemindMe = false
        
        
        let newTask2 = Task(context: context)
        newTask2.date = Date(timeIntervalSinceNow: 2)
        newTask2.content = "\("newUserTask2".localized()) 👉🏻"
        newTask2.completion = false
        newTask2.isRemindMe = false

        
        let newTask3 = Task(context: context)
        newTask3.date = Date(timeIntervalSinceNow: 3)
        newTask3.content = "👀 \("newUserTask3".localized())"
        newTask3.completion = false
        newTask3.isRemindMe = false

        
        let newTask4 = Task(context: context)
        newTask4.date = Date(timeIntervalSinceNow: 4)
        newTask4.content = "\("newUserTask4".localized()) 👇🏻"
        newTask4.completion = false
        newTask4.isRemindMe = false
        
        let newTask5 = Task(context: context)
        newTask5.date = Date(timeIntervalSinceNow: 5)
        newTask5.content = "\("newUserTask5".localized()) 🛒"
        newTask5.completion = false
        newTask5.isRemindMe = false

        
        let newTask6 = Task(context: context)
        newTask6.date = Date(timeIntervalSinceNow: 6)
        newTask6.content = "newUserTask6".localized()
        newTask6.completion = false
        newTask6.isRemindMe = false
        
        
        // saving data
        do{
            try context.save()
            
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    
    // Share with Friends
    func sharePost(message: String) {
        
        
        let message = message
        let image = Image("iconLarge")
        let link = URL(string: "https://apps.apple.com/us/app/id1565858619")!
        
        let activityViewController = UIActivityViewController(activityItems: [message, image, link], applicationActivities: nil)
        
        let viewController = UIApplication.shared.windows.first?.rootViewController
        viewController?.present(activityViewController, animated: true, completion: nil)
    }
    
    
    
    
    // Random placeholder for newData
    func randomTextGenerator() -> String {
        let pht = [
            "randomNewTaskGenerator1".localized(),
            "randomNewTaskGenerator2".localized(),
            "randomNewTaskGenerator3".localized(),
            "randomNewTaskGenerator4".localized(),
            "randomNewTaskGenerator5".localized(),
            "randomNewTaskGenerator6".localized(),
            "randomNewTaskGenerator7".localized(),
            "randomNewTaskGenerator8".localized(),
            "randomNewTaskGenerator9".localized()
        ]
        let randomText = "\("tapToAddTask".localized()) \n\("ie".localized()) \(pht.randomElement()!)"
        return String(randomText)
        
    }
    
    // Finding time of the day
    func getTimeOfTheDay() -> String {
        
        let calculatedCalender = calender.component(.hour, from:Date())
        
        if calculatedCalender > 5 && calculatedCalender <= 11 {
            return "goodMorning".localized()
        } else if calculatedCalender > 11 && calculatedCalender <= 16 {
            return "goodAfternoon".localized()
        } else if calculatedCalender > 16 && calculatedCalender <= 20 {
            return "goodEvening".localized()
        } else {
            return "goodNight".localized()
        }
        
        

    }
    
    
  
     // Ckeck task inside spesific date
     func checkTaskInsideSelectedDate(task: Task) -> Bool {
         
         // Başlangıç tarihi işlemleri
         let dateFrom = Calendar.current.startOfDay(for: filterDate)
         
         // Bitiş tarihi işlemleri - başlangıç tarihine +1 gün eklenir.
         var dateComponents = DateComponents()
         dateComponents.setValue(1, for: .day)
         let dateTo = Calendar.current.date(byAdding: dateComponents, to: Calendar.current.startOfDay(for: filterDate))!
         
         // kontrol işlemi
         if task.date! >= dateFrom && task.date! <= dateTo {
             return true
         }
         return false
     }
     
 
    
    // Ckeck task inside today
    func checkTaskInsideToday(task: Task) -> Bool {
        
        // Başlangıç tarihi işlemleri
        let dateFrom = Calendar.current.startOfDay(for: Date())
        
        // Bitiş tarihi işlemleri - başlangıç tarihine +1 gün eklenir.
        var dateComponents = DateComponents()
        dateComponents.setValue(1, for: .day)
        let dateTo = Calendar.current.date(byAdding: dateComponents, to: Calendar.current.startOfDay(for:  Date()))!
        
        // kontrol işlemi
        if task.date! >= dateFrom && task.date! <= dateTo  {
            return true
        }
        return false
    }
    
    
    
    // Ckeck task inside nextweek
    func checkTaskInsideNextWeek(task: Task) -> Bool {
        
        // Başlangıç tarihi işlemleri - tomorrow
        var dateComponents1 = DateComponents()
        dateComponents1.setValue(2, for: .day)
        let dateFrom = Calendar.current.date(byAdding: dateComponents1, to: Calendar.current.startOfDay(for: Date()))!
        
        // Bitiş tarihi işlemleri - başlangıç tarihine +1 gün eklenir.
        var dateComponents = DateComponents()
        dateComponents.setValue(9, for: .day)
        let dateTo = Calendar.current.date(byAdding: dateComponents, to: Calendar.current.startOfDay(for: Date()))!
        
        // kontrol işlemi
        if task.date! >= dateFrom && task.date! <= dateTo {
            return true
        }
        return false
    }
    
    
    func findNextWeekDates() -> String {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        
        // Başlangıç Tarihi
        var dateComponents1 = DateComponents()
        dateComponents1.setValue(2, for: .day)
        let dateFrom = Calendar.current.date(byAdding: dateComponents1, to: Calendar.current.startOfDay(for: Date()))!
        
        // Bitiş tarihi işlemleri - başlangıç tarihine +1 gün eklenir.
        var dateComponents = DateComponents()
        dateComponents.setValue(8, for: .day)
        let dateTo = Calendar.current.date(byAdding: dateComponents, to: Calendar.current.startOfDay(for: Date()))!
        
        return "\(formatter.string(from: dateFrom)) - \(formatter.string(from: dateTo))"
        
    }
    
    
    // Ckeck task inside tomorrow
    func checkTomorrowAll(task: Task) -> Bool {
        
        // Başlangıç tarihi işlemleri - tomorrow
        var dateComponents1 = DateComponents()
        dateComponents1.setValue(1, for: .day)
        let dateFrom = Calendar.current.date(byAdding: dateComponents1, to: Calendar.current.startOfDay(for: Date()))!
        
        // Bitiş tarihi işlemleri - başlangıç tarihine +1 gün eklenir.
        var dateComponents = DateComponents()
        dateComponents.setValue(2, for: .day)
        let dateTo = Calendar.current.date(byAdding: dateComponents, to: Calendar.current.startOfDay(for: Date()))!
        
        // kontrol işlemi
        if task.date! >= dateFrom && task.date! <= dateTo {
            return true
        }
        return false
    }
    
    func getTimeDiff(startingTime : Date) -> DateComponents {
        let date1 = startingTime
        let date2 = Date()
        
        let diff = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date1, to: date2)
        return diff
    }
  
    
}




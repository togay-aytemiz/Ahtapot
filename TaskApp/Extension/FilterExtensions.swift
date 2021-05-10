//
//  FilterExtensions.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 22.04.2021.
//

import SwiftUI


extension NSPredicate {
    
    enum DateType: String {
        case tomorrow = "Yarın"
        case today = "Bugün"
        
        
        func date() -> NSDate {
            switch self {
            case .tomorrow:
                var dateComponents = DateComponents()
                dateComponents.setValue(1, for: .day)
                dateComponents.setValue(0, for: .hour) // EKLENDİ
                return Calendar.current.date(byAdding: dateComponents, to: Calendar.current.startOfDay(for: Date()))! as NSDate
                
            case .today:
                var dateComponents = DateComponents()
                dateComponents.setValue(0, for: .hour) // EKLENDİ
                return Calendar.current.date(byAdding: dateComponents, to: Calendar.current.startOfDay(for: Date()))! as NSDate
                
            }
            
        }
        
        
    }

    
    
    
   
    // ------------------------------ WORKIN FUNCTIONS DONT TOUCH ------------------------------ //
    
    // BEKLEYEN TASKLAR
    static func OpenTasks() -> NSPredicate {
        let justwaitingfilter = NSPredicate(format: "completion == %@", NSNumber(value: false))
        return justwaitingfilter
    }
    
    // TAMAMLANMIŞ TASKLAR
    static func ClosedTasks() -> NSPredicate {
        let closedTasks = NSPredicate(format: "completion == %@", NSNumber(value: true))
        return closedTasks
    }
    
    // SADECE BUGÜN & BEKLEYEN + TAMAMLANMIŞ
    static func justTodayAll() -> NSPredicate {
        let dateFrom = DateType.today.date()
        let dateTo = DateType.tomorrow.date()
        let calculatedPredicate = NSPredicate(format: "date >= %@ AND date < %@", dateFrom, dateTo)
        return calculatedPredicate
    }
    
    // SADECE BUGÜN & TAMAMLANMIŞ
    static func justTodayClosed() -> NSCompoundPredicate {
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [justTodayAll(), ClosedTasks()])
        return predicate
    }
    
    // SADECE BUGÜN & SADECE BEKLEYEN
    static func justTodayOpen() -> NSCompoundPredicate {
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [justTodayAll(), OpenTasks()])
        return predicate
    }

    // GEÇMİŞ & BEKLEYEN + TAMAMLANMIŞ
    static func beforeTodayAll() -> NSPredicate {
        let dateFrom = DateType.today.date()
        //let dateTo = DateType.tomorrow.date()
        let calculatedPredicate = NSPredicate(format: "date < %@", dateFrom)
        return calculatedPredicate
    }
        
    // GEÇMİŞ & SADECE BEKLEYEN
    static func beforeTodayOpen() -> NSCompoundPredicate {
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [beforeTodayAll(), OpenTasks()])
        return predicate
    }
    
    
    // GEÇMİŞ & SADECE TAMAMLANMIŞ
    static func beforeTodayClosed() -> NSCompoundPredicate {
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [beforeTodayAll(), ClosedTasks()])
        return predicate
    }
        
    // GELECEK & & BEKLEYEN + TAMAMLANMIŞ
    static func futureAll() -> NSPredicate {
        //let dateFrom = DateType.today.date()
        let dateTo = DateType.tomorrow.date()
        let calculatedPredicate = NSPredicate(format: "date >= %@", dateTo)
        return calculatedPredicate
    }
    
    // GELECEK & SADECE BEKLEYEN
    static func futureOpen() -> NSCompoundPredicate {
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [futureAll(), OpenTasks()])
        return predicate
    }
    
    

}


extension Date {
    func adding(minutes: Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minutes, to: self)!
    }
}

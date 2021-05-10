//
//  DateSelectionViewForMainPage.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 8.05.2021.
//

import SwiftUI

struct DateSelectionViewForMainPage: View {
    // MARK: PROPERTIES
    
    
    @StateObject var homeData = HomeViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var dateForIcon: String {
        let formatter3 = DateFormatter()
        formatter3.dateFormat = "dd"
        return formatter3.string(from: homeData.filterDate)
    }
    
    var findTomorrowForIcon: String {
        var dateComponents = DateComponents()
        dateComponents.setValue(1, for: .day)
        let dateTo = Calendar.current.date(byAdding: dateComponents, to: Calendar.current.startOfDay(for: homeData.filterDate))!
        let formatter3 = DateFormatter()
        formatter3.dateFormat = "dd"
        return formatter3.string(from: dateTo)
        
    }
    
    var find2DaysLaterForIcon: String {
        var dateComponents = DateComponents()
        dateComponents.setValue(2, for: .day)
        let dateTo = Calendar.current.date(byAdding: dateComponents, to: Calendar.current.startOfDay(for: homeData.filterDate))!
        let formatter3 = DateFormatter()
        formatter3.dateFormat = "dd"
        return formatter3.string(from: dateTo)
        
    }
    
    // FETCHING DETAILS
    @Environment(\.managedObjectContext) var context
    
    @FetchRequest(
            entity: Task.entity(),
            sortDescriptors: [NSSortDescriptor(key: "date",ascending: true)],
            predicate: nil,
            animation: .spring()
        ) var tasks : FetchedResults<Task>


    var filteredTasks: [Task] {
        let filteredTasks = tasks.filter { task in
            return homeData.checkTaskToSelectedDate(task: task)
        }
        return filteredTasks
      }
    
    
    
    
    
    // MARK: BODY
    var body: some View {
        VStack(spacing: 16) {
            
            ScrollView {
                VStack{

                
                    // DATEPICKER
                    DatePicker("", selection: $homeData.filterDate,   displayedComponents: [.date])
                        .environment(\.locale, Locale.init(identifier: "tr"))
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .frame(width: UIScreen.main.bounds.width - 30)
                    
                    
                    
                    
                    if filteredTasks.count == 0 {
                        Text("there is no task")
                            .padding()
                    }
                    
                    VStack(spacing: 0) {
                        ForEach(filteredTasks) { task in
                            ListRowItemView(homeData: task) {
                                homeData.editItem(item: task)
                            } editAction: {
                                homeData.editItem(item: task)
                            } deleteAction: {
                                context.delete(task)
                                NotificationManager.istance.cancelNotification(idArray: ["\(task.content!)"])
                            }
                            
                        }
                    }
                    
                    
                    Spacer()
                }
            }
        }
        .background(EmptyView().sheet(isPresented : $homeData.isNewData) {NewDataView(homeData: homeData)})

    }
}


// MARK: PREVIEW
struct DateSelectionViewForMainPage_Previews: PreviewProvider {
    static var previews: some View {
        DateSelectionViewForMainPage()
    }
}


/*
 
 
 
 Spacer()
 
 //TODAY
 Button(action: {
     homeData.filterDate = Date()
     //presentationMode.wrappedValue.dismiss()
 }, label: {
     HStack(spacing: 16){
         Image(systemName: "\(dateForIcon).square")
             .foregroundColor(Color.orange)
             .font(.system(size: 20, weight: .semibold, design: .rounded))
         
         VStack(alignment: .leading) {
             Text("Bugün")
                 .font(.system(.subheadline, design: .rounded))
                 .fontWeight(.semibold)
             
             Text("12 adet görev")
                 .font(.system(.subheadline, design: .rounded))
                 .fontWeight(.light)
         }
         
         Spacer()
         
         if homeData.checkFilterDate() == "Bugün" {
             Image(systemName: "checkmark.circle.fill")
                 .foregroundColor(Color(Utils.AppColor1))
                 .font(.system(size: 20, weight: .semibold, design: .rounded))
         }
         
         
         
     }
     .padding(.horizontal, 16)
     .padding(.vertical)
     .overlay(
         RoundedRectangle(cornerRadius: 8)
             .stroke(lineWidth: 1)
             .foregroundColor(Color.gray.opacity(0.7))
     )
 })
 
 
 
 
 //TOMORROW
 Button(action: {
     homeData.filterDate = Date(timeIntervalSinceNow: 86400)
     //presentationMode.wrappedValue.dismiss()
 }, label: {
     HStack(spacing: 16){
         Image(systemName: "\(findTomorrowForIcon).square")
             .foregroundColor(Color.green)
             .font(.system(size: 20, weight: .semibold, design: .rounded))
         
         VStack(alignment: .leading) {
             Text("Yarın")
                 .font(.system(.subheadline, design: .rounded))
                 .fontWeight(.semibold)
             
             Text("8 adet görev")
                 .font(.system(.subheadline, design: .rounded))
                 .fontWeight(.light)
         }
         
         Spacer()
         
         if homeData.checkFilterDate() == "Yarın" {
             Image(systemName: "checkmark.circle.fill")
                 .foregroundColor(Color(Utils.AppColor1))
                 .font(.system(size: 20, weight: .semibold, design: .rounded))
         }
         
         
         
     }
     .padding(.horizontal, 16)
     .padding(.vertical)
     .overlay(
         RoundedRectangle(cornerRadius: 8)
             .stroke(lineWidth: 1)
             .foregroundColor(Color.gray.opacity(0.7))
     )
 })
 
 
 
 

 
 
 
 
 
 
 
 Spacer()
 
 
 */

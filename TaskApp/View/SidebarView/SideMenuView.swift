//
//  SideMenuView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 10.05.2021.
//

import SwiftUI

struct SideMenuView: View {
    // MARK: PROPERTIES
    
    @Binding var isShowingSideMenu: Bool
    @Binding var selectedTab: String
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
    
    // FETCH REQUESTS
    
    @Environment(\.managedObjectContext) var context
    
    @FetchRequest(
            entity: Task.entity(),
            sortDescriptors: [NSSortDescriptor(key: "date",ascending: true)],
            predicate: nil,
            animation: .spring()
        ) var tasks : FetchedResults<Task>


    
    
    var filteredTasksToday: [Task] {
        let filteredTasks = tasks.filter { task in
            return homeData.checkTaskInsideToday(task: task) && !task.completion
        }
        return filteredTasks
      }
    
    
    var filteredTasksTomorrow: [Task] {
        let filteredTasks = tasks.filter { task in
            return homeData.checkTomorrowAll(task: task) && !task.completion
        }
        return filteredTasks
      }
    
    var filteredTasksNextWeek: [Task] {
        let filteredTasks = tasks.filter { task in
            return homeData.checkTaskInsideNextWeek(task: task) && !task.completion
        }
        return filteredTasks
      }
    
    
    var allOpenTasks: [Task] {
        let filteredTasks = tasks.filter { task in
            return !task.completion
        }
        return filteredTasks
      }
    
    
    
    
    
    
    
    // MARK: BODY
    var body: some View {
        ZStack{

            Utils.AppThemeBackgroundColor.edgesIgnoringSafeArea(.all)
            
            
            VStack(alignment: .leading){
                
                //HEADER
                SideMenuHeaderView(isShowingSideMenu: $isShowingSideMenu)
                
                Spacer()
                
                
                
                //OPTIONS
                
                VStack(alignment: .leading, spacing: 0, content: {
                    
                    SideMenuOptionView(isShowingSideMenu: $isShowingSideMenu, isSelectedTab: selectedTab == "today" ? true : false, image: Image(systemName: "\(dateForIcon).square"), text: "Bugün", taskNumber: filteredTasksToday.count, isTaskNumberShow: true) {
                        selectedTab = "today"
                    }
                    
                    SideMenuOptionView(isShowingSideMenu: $isShowingSideMenu, isSelectedTab: selectedTab == "tomorrow" ? true : false, image: Image(systemName: "\(findTomorrowForIcon).square"), text: "Yarın", taskNumber: filteredTasksTomorrow.count, isTaskNumberShow: true) {
                        selectedTab = "tomorrow"
                    }
                    
                    SideMenuOptionView(isShowingSideMenu: $isShowingSideMenu, isSelectedTab: selectedTab == "next7days" ? true : false, image: Image(systemName: "calendar.badge.clock"), text: "Sonraki 7 gün", taskNumber: filteredTasksNextWeek.count, isTaskNumberShow: true, descriptionText: homeData.findNextWeekDates()) {
                        selectedTab = "next7days"
                    }
                    
                    SideMenuOptionView(isShowingSideMenu: $isShowingSideMenu, isSelectedTab: selectedTab == "allTasks" ? true : false, image: Image(systemName: "list.bullet"), text: "Tüm Görevler", taskNumber: allOpenTasks.count, isTaskNumberShow: true) {
                        selectedTab = "allTasks"
                    }
                    
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 150, height: 1.5)
                        .cornerRadius(12)
                        .padding()
                        .padding(.leading)
                })
                
                
                
                
                
                Spacer()
                Spacer()
                
                VStack(alignment: .leading, spacing: 0) {
                    
//                    Rectangle()
//                        .fill(Color.white)
//                        .frame(width: 150, height: 1.5)
//                        .cornerRadius(12)
//                        .padding()
                    
                    SideMenuOptionView(isShowingSideMenu: $isShowingSideMenu, isSelectedTab: selectedTab == "settings" ? true : false, image: Image("settings"), text: "Ayarlar") {
                        selectedTab = "settings"
                    }
                }
                .padding(.bottom, 40)
                
                
                
                
//                ForEach(SideMenuViewModel.allCases, id:\.self) { options in
//                    Button(action: {
//                        withAnimation(.spring()) {
//                            selectedTab = options.title
//                            isShowingSideMenu = false
//                        }
//                    }, label: {
//                        //SideMenuOptionView(viewmodel: options, isSelectedTab: selectedTab == options.title ? true : false)
//                    })
//
//
//                }
                
                
                
            }
            
            
        }
    }
}


// MARK: PREVIEW
struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(isShowingSideMenu: .constant(false), selectedTab: .constant("bugün"))
    }
}

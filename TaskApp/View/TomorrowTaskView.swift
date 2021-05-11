//
//  TomorrowTaskView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 11.05.2021.
//

import SwiftUI

struct TomorrowTaskView: View {
    // MARK: PROPERTIES
    
    @StateObject var homeData = HomeViewModel()
    @EnvironmentObject var obj: observed
    
    
    // TABBAR DEĞİŞİMİ İÇİN STATE
    @Binding var selectedTab: String
    
    
    // FETCHING DETAILS
    @Environment(\.managedObjectContext) var context
    
    
    
    // Shopping View
    @FetchRequest(entity: Shopping.entity(),sortDescriptors: [NSSortDescriptor(key: "date",ascending: false)],predicate: .OpenTasks(), animation: .spring()) var openShoppingListItem : FetchedResults<Shopping>
    
    // OTHER DETAILS
    let haptics = UIImpactFeedbackGenerator()
    
    
    // Fetch Open Tasks
    @FetchRequest(entity: Task.entity(),sortDescriptors: [NSSortDescriptor(key: "date",ascending: true)],predicate: nil, animation: .spring()) var allOpenTasks : FetchedResults<Task>
    
    
    
    var tomorrowOpenTasks: [Task] {
        let filteredTasks = allOpenTasks.filter { task in
            return homeData.checkTomorrowAll(task: task) && !task.completion
        }
        return filteredTasks
      }
    
    
    var tomorrowClosedTasks: [Task] {
        let filteredTasks = allOpenTasks.filter { task in
            return homeData.checkTomorrowAll(task: task) && task.completion
        }
        return filteredTasks
      }
    
    
    
    
    
    @State private var isShowingSideMenu = false
    @AppStorage("isJustTomorrowOpenShown") var isJustTomorrowOpenShown: Bool = false
    
    
    var showingDate : Date {
        var dateComponents1 = DateComponents()
        dateComponents1.setValue(1, for: .day)
        let tomorrow = Calendar.current.date(byAdding: dateComponents1, to: Calendar.current.startOfDay(for: Date()))!
        return tomorrow
        
    }
    
    
    
    
    // MARK: BODY
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            
            if isShowingSideMenu {
                SideMenuView(isShowingSideMenu: $isShowingSideMenu, selectedTab: $selectedTab)
            }
            
            ZStack {
                VStack{
                    // MARK: HEADER
                    CustomNavigationBarView(shoppingItem: openShoppingListItem.count, customNavigationHeader: "Yarın", isShowingSideMenu: $isShowingSideMenu, showingDate: showingDate)
                        .background(Utils.isDarkMode ? Color.black : Color.white)
                    
                    
                    Spacer()
                    
                    
                    if tomorrowOpenTasks.count == 0 {
                        EmptyViewIllustrations(image: "noTodo", text: "Yarın için yapılacak listen boş.\nHadi hemen ekleyelim... 💪🏻", header: "YARIN YAPILACAK YOK")
                        Spacer()
                    }
                    else {
                        
                        ScrollView(.vertical, showsIndicators: false){
                            
                            VStack(spacing: 0){
                                
                                SearchViewForMainPage()
                                
                                
                                // SOME STATS ABOUT TODAY
                                
                                
                                
                                ForEach(tomorrowOpenTasks) { task in
                                    ListRowItemView(homeData: task) {
                                        homeData.editItem(item: task)
                                    } editAction: {
                                        homeData.editItem(item: task)
                                    } deleteAction: {
                                        context.delete(task)
                                        NotificationManager.istance.cancelNotification(idArray: ["\(task.content!)"])
                                    }
                                }
                                
                                if tomorrowClosedTasks.count > 0 {
                                    
                                    if isJustTomorrowOpenShown {
                                        
                                        // BUGÜN KAPANANLAR
                                        ForEach(tomorrowClosedTasks) { task in
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
                                    
                                    Button(action: {
                                        isJustTomorrowOpenShown.toggle()
                                        haptics.impactOccurred()
                                    }, label: {
                                        HStack {
                                            Text(!isJustTomorrowOpenShown ? "Tamamlananları Göster" : "Tamamlananları Gizle")
                                                .font(.system(.subheadline, design: .rounded))
                                            Image(systemName: !isJustTomorrowOpenShown ? "chevron.down" : "chevron.up")
                                        }
                                        .animation(.easeIn)
                                        .foregroundColor(.secondary)
                                        .padding()
                                    })
                                    
                                }
        
                            }
                            .padding(.bottom, 80)
                            
                        }
                        
                        
                    }
                    
                }
                
            }
            .background(EmptyView().sheet(isPresented : $homeData.isNewData) {NewDataView(homeData: homeData)})
            .edgesIgnoringSafeArea(.bottom)
            .onAppear { UIApplication.shared.applicationIconBadgeNumber = 0 }
            .background(Utils.isDarkMode ? Color.black : Color.white)
            
            // SIDE MENU ACTIONS
            .cornerRadius(isShowingSideMenu ? 20 : 0)
            .scaleEffect(isShowingSideMenu ? 0.8 : 1)
            .offset(x: isShowingSideMenu ? (UIScreen.screenWidth / 5 * 3) : 0, y: isShowingSideMenu ? (UIScreen.screenHeight / 17) : 0)
            .shadow(color: Color.black.opacity(isShowingSideMenu ? 0.2 : 0), radius: 8, x: -5, y: 5 )
            .disabled(isShowingSideMenu)
            
            
            
            if !isShowingSideMenu  {
                MiniAddTaskButtonView {
                    homeData.isNewData.toggle()
                    homeData.content = ""
                    homeData.updateItem = nil
                    homeData.completion = false
                    homeData.date = Date(timeIntervalSinceNow: 3600*24)
                    homeData.isRemindMe = false
                }
                
            }
            
        }
        
        
        
    }
}



// MARK: PREVIEW
struct TomorrowTaskView_Previews: PreviewProvider {
    static var previews: some View {
        TomorrowTaskView(selectedTab: .constant("tomorrow"))
    }
}



/*
 
 ForEach(tomorrowOpenTasks) { task in
     ListRowItemView(homeData: task) {
         homeData.editItem(item: task)
     } editAction: {
         homeData.editItem(item: task)
     } deleteAction: {
         context.delete(task)
         NotificationManager.istance.cancelNotification(idArray: ["\(task.content!)"])
     }
     
 }
 
 
 Text("kapanlar")

 
 ForEach(tomorrowClosedTasks) { task in
     ListRowItemView(homeData: task) {
         homeData.editItem(item: task)
     } editAction: {
         homeData.editItem(item: task)
     } deleteAction: {
         context.delete(task)
         NotificationManager.istance.cancelNotification(idArray: ["\(task.content!)"])
     }
     
 }
 
 */

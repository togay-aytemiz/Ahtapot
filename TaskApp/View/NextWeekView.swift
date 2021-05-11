//
//  NextWeekView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 11.05.2021.
//

import SwiftUI

struct NextWeekView: View {
    // MARK: PROPERTIES
    
    @StateObject var homeData = HomeViewModel()
    @EnvironmentObject var obj: observed
    
    // OTHER DETAILS
    let haptics = UIImpactFeedbackGenerator()
    
    // TABBAR DEĞİŞİMİ İÇİN STATE
    @Binding var selectedTab: String
    
    
    // FETCHING DETAILS
    @Environment(\.managedObjectContext) var context
    
    
    // Shopping View
    @FetchRequest(entity: Shopping.entity(),sortDescriptors: [NSSortDescriptor(key: "date",ascending: false)],predicate: .OpenTasks(), animation: .spring()) var openShoppingListItem : FetchedResults<Shopping>
    
    // Fetch Open Tasks
    @FetchRequest(entity: Task.entity(),sortDescriptors: [NSSortDescriptor(key: "date",ascending: true)],predicate: nil, animation: .spring()) var allOpenTasks : FetchedResults<Task>
    
    
    
    var next7DaysOpenTasks: [Task] {
        let filteredTasks = allOpenTasks.filter { task in
            return homeData.checkTaskInsideNextWeek(task: task) && !task.completion
        }
        return filteredTasks
      }
    
    
    var next7DaysClosedTasks: [Task] {
        let filteredTasks = allOpenTasks.filter { task in
            return homeData.checkTaskInsideNextWeek(task: task) && task.completion
        }
        return filteredTasks
      }
    
    
    
    @State private var isShowingSideMenu = false
    @AppStorage("isJustNext7DaysOpenShown") var isJustNext7DaysOpenShown: Bool = false

    

    
    
    
    // MARK: BODY
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            
            if isShowingSideMenu {
                SideMenuView(isShowingSideMenu: $isShowingSideMenu, selectedTab: $selectedTab)
            }
            
            ZStack {
                VStack{
                    // MARK: HEADER
                    CustomNavigationBarView(showDate: false, shoppingItem: openShoppingListItem.count, customNavigationHeader: "Sonraki 7 Gün", isShowingSideMenu: $isShowingSideMenu, description: homeData.findNextWeekDates())
                        .background(Utils.isDarkMode ? Color.black : Color.white)
                    
                    
                    
                    Spacer()
                    
                    
                    if next7DaysOpenTasks.count == 0 {
                        EmptyViewIllustrations(image: "noTodo", text: "\(homeData.findNextWeekDates())\ntarih aralığı için yapılacak görev yok.\nHadi hemen ekleyelim... 💪🏻", header: "YAPILACAK GÖREV YOK")
                        Spacer()
                    }
                    else {
                        
                        ScrollView(.vertical, showsIndicators: false){
                            
                            VStack(spacing: 0){
                                
                                SearchViewForMainPage()
                                
                                
                                // SOME STATS ABOUT TODAY
                                
                                
                                
                                ForEach(next7DaysOpenTasks) { task in
                                    ListRowItemView(homeData: task) {
                                        homeData.editItem(item: task)
                                    } editAction: {
                                        homeData.editItem(item: task)
                                    } deleteAction: {
                                        context.delete(task)
                                        NotificationManager.istance.cancelNotification(idArray: ["\(task.content!)"])
                                    }
                                }
                                
                                if next7DaysClosedTasks.count > 0 {
                                    
                                    if isJustNext7DaysOpenShown {
                                        
                                        // BUGÜN KAPANANLAR
                                        ForEach(next7DaysClosedTasks) { task in
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
                                        isJustNext7DaysOpenShown.toggle()
                                        haptics.impactOccurred()
                                    }, label: {
                                        HStack {
                                            Text(!isJustNext7DaysOpenShown ? "Tamamlananları Göster" : "Tamamlananları Gizle")
                                                .font(.system(.subheadline, design: .rounded))
                                            Image(systemName: !isJustNext7DaysOpenShown ? "chevron.down" : "chevron.up")
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
                Rectangle()
                    .fill(Color.black).edgesIgnoringSafeArea(.all)
                    .opacity(isShowingSideMenu ? 0.1 : 0)
                    .onTapGesture {
                        withAnimation(.spring()){
                            isShowingSideMenu.toggle()
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
            //.disabled(isShowingSideMenu)
            
            
            if !isShowingSideMenu  {
                MiniAddTaskButtonView {
                    homeData.isNewData.toggle()
                    homeData.content = ""
                    homeData.updateItem = nil
                    homeData.completion = false
                    homeData.date = Date(timeIntervalSinceNow: 3600*24*2)
                    homeData.isRemindMe = false
                }
                
            }
            
        } 
    }
}



// MARK: PREVIEW
struct NextWeekView_Previews: PreviewProvider {
    static var previews: some View {
        NextWeekView(selectedTab: .constant("next7days"))
    }
}

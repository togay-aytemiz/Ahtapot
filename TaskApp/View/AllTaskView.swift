//
//  AllTaskView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 11.05.2021.
//

import SwiftUI

struct AllTaskView: View {
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
    
    
    
    var filteredallOpenTasks: [Task] {
        let filteredTasks = allOpenTasks.filter { task in
            return !task.completion
        }
        return filteredTasks
      }
    
    
    var allClosedTasks: [Task] {
        let filteredTasks = allOpenTasks.filter { task in
            return task.completion
        }
        return filteredTasks
      }
    
    
    
    @State private var isShowingSideMenu = false
    @AppStorage("isJAllOpenShown") var isJAllOpenShown: Bool = false
    
    
    
    // MARK: BODY
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            
            if isShowingSideMenu {
                SideMenuView(isShowingSideMenu: $isShowingSideMenu, selectedTab: $selectedTab)
            }
            
            ZStack {
                VStack{
                    // MARK: HEADER
                    CustomNavigationBarView(showDate: false, shoppingItem: openShoppingListItem.count, customNavigationHeader: "Tüm Görevler", isShowingSideMenu: $isShowingSideMenu)
                        .background(Utils.isDarkMode ? Color.black : Color.white)
                    
                    
                    
                    Spacer()
                    
                    
                    if filteredallOpenTasks.count == 0 {
                        EmptyViewIllustrations(image: "noTodo", text: "Yapılacaklar listen boş.\nHadi hemen ekleyelim... 💪🏻", header: "HİÇ GÖREV YOK")
                        Spacer()
                    }
                    else {
                        
                        ScrollView(.vertical, showsIndicators: false){
                            
                            VStack(spacing: 0){
                                
                                SearchViewForMainPage()
                                
                                
                                // SOME STATS ABOUT TODAY
                                
                                
                                
                                ForEach(filteredallOpenTasks) { task in
                                    ListRowItemView(homeData: task) {
                                        homeData.editItem(item: task)
                                    } editAction: {
                                        homeData.editItem(item: task)
                                    } deleteAction: {
                                        context.delete(task)
                                        NotificationManager.istance.cancelNotification(idArray: ["\(task.content!)"])
                                    }
                                }
                                
                                if allClosedTasks.count > 0 {
                                    
                                    if isJAllOpenShown {
                                        
                                        // BUGÜN KAPANANLAR
                                        ForEach(allClosedTasks) { task in
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
                                        isJAllOpenShown.toggle()
                                        haptics.impactOccurred()
                                    }, label: {
                                        HStack {
                                            Text(!isJAllOpenShown ? "Tamamlananları Göster" : "Tamamlananları Gizle")
                                                .font(.system(.subheadline, design: .rounded))
                                            Image(systemName: !isJAllOpenShown ? "chevron.down" : "chevron.up")
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
                    homeData.date = Date(timeIntervalSinceNow: 3600)
                    homeData.isRemindMe = false
                }
                
            }
            
        }
    }
}

struct AllTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AllTaskView(selectedTab: .constant("allTasks"))
    }
}

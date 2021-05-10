//
//  MainTaskView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 22.04.2021.
//

import SwiftUI

struct MainTaskView: View {
    // MARK: PROPERTIES
    
    
    @StateObject var homeData = HomeViewModel()
    @EnvironmentObject var obj: observed
    
    // USERDEFAULTS SEÇENEKLERİ
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @AppStorage("isJustTodayOpenShown") var isJustTodayOpenShown: Bool = false
    @AppStorage("isFirstTimeUsingApp") private var isFirstTimeUsingApp: Bool = true

    
    // TABBAR DEĞİŞİMİ İÇİN STATE
    @State var selectedTab: String = "home"
    
    
    // FETCHING DETAILS
    @Environment(\.managedObjectContext) var context
    
    
    // Fetch All Tasks
    @FetchRequest(entity: Task.entity(),sortDescriptors: [NSSortDescriptor(key: "date",ascending: true)], animation: .spring()) var results : FetchedResults<Task>
    
    // Fetch Open Tasks
    @FetchRequest(entity: Task.entity(),sortDescriptors: [NSSortDescriptor(key: "date",ascending: true)],predicate: .OpenTasks(), animation: .spring()) var allOpenTasks : FetchedResults<Task>
    @FetchRequest(entity: Task.entity(),sortDescriptors: [NSSortDescriptor(key: "date",ascending: true)],predicate: .justTodayAll(), animation: .spring()) var justTodayAll : FetchedResults<Task>
    @FetchRequest(entity: Task.entity(),sortDescriptors: [NSSortDescriptor(key: "date",ascending: true)],predicate: .justTodayOpen(), animation: .spring()) var justTodayOpen : FetchedResults<Task>
    @FetchRequest(entity: Task.entity(),sortDescriptors: [NSSortDescriptor(key: "date",ascending: true)],predicate: .beforeTodayOpen(), animation: .spring()) var beforeTodayOpen : FetchedResults<Task>
    @FetchRequest(entity: Task.entity(),sortDescriptors: [NSSortDescriptor(key: "date",ascending: true)],predicate: .futureOpen(), animation: .spring()) var futureOpen : FetchedResults<Task>
    @FetchRequest(entity: Task.entity(),sortDescriptors: [NSSortDescriptor(key: "date",ascending: true)],predicate: .beforeTodayAll(), animation: .spring()) var beforeTodayAll : FetchedResults<Task>
    
    // Fetch Closed Tasks
    @FetchRequest(entity: Task.entity(),sortDescriptors: [NSSortDescriptor(key: "date",ascending: true)],predicate: .ClosedTasks(),animation: .spring()) var closedTasks : FetchedResults<Task>
    @FetchRequest(entity: Task.entity(),sortDescriptors: [NSSortDescriptor(key: "date",ascending: true)],predicate: .justTodayClosed(), animation: .spring()) var justTodayClosed : FetchedResults<Task>
    @FetchRequest(entity: Task.entity(),sortDescriptors: [NSSortDescriptor(key: "date",ascending: true)],predicate: .beforeTodayClosed(), animation: .spring()) var beforeTodayClosed : FetchedResults<Task>
    
    // Shopping View
    @FetchRequest(entity: Shopping.entity(),sortDescriptors: [NSSortDescriptor(key: "date",ascending: false)],predicate: .OpenTasks(), animation: .spring()) var openShoppingListItem : FetchedResults<Shopping>
    
    
    // OTHER DETAILS
    let haptics = UIImpactFeedbackGenerator()
    
    
    @State private var isShowingSideMenu = false
    
    
    // MARK: BODY
    var body: some View {
        
        
        
        ZStack{
        
            if isShowingSideMenu {
                SideMenuView(isShowingSideMenu: $isShowingSideMenu, selectedTab: $selectedTab)
            }
            
            ZStack {
                // MAIN VIEW
                VStack(spacing: 0){
                    

                    // MARK: HEADER
                    NavigationBarView(title: homeData.getTimeOfTheDay(), showDate: true, shoppingIcon: true, searchIcon: true, shoppingItem: openShoppingListItem.count)
                        .padding(.top)
                        .padding(.horizontal, 15)
                        .padding(.bottom)
                        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                        //.background(isDarkMode ? Color.black : Color.white)
                        .animation(.easeIn)
                    
                    
                    HStack{
                        Button(action: {
                            withAnimation(.spring()) {
                                isShowingSideMenu.toggle()
                            }
                        }, label: {
                            Image(systemName: "text.alignleft")
                                .font(.system(size: 24, weight: .light, design: .rounded))
                                .padding(.trailing)
                                .foregroundColor(.black)
                        })
                        .padding()
                        
                        Spacer()
                            
                    }
                    
                    Spacer()
                    
                    if allOpenTasks.count == 0 && justTodayClosed.count == 0 {
                        EmptyViewIllustrations(image: "noTodo", text: "Yapılacaklar listen boş.\nHadi hemen ekleyelim... 💪🏻", header: "HİÇ GÖREV YOK")
                        Spacer()
                    }
                    else {
                        
                        
                        // MARK: CONTENT
                        ScrollView(.vertical, showsIndicators: false, content: {
                            
                            VStack(spacing: 0){
                                
                                SearchViewForMainPage()
                                
                                // MARK: BASIC STATS
                                
                                //HomePageDateFilterView()
                                
                                if Utils.isBasicStatView {
                                    if allOpenTasks.count > 0 || justTodayClosed.count > 0 {
                                        StatsView(numberOfPreviousTask: beforeTodayOpen.count, numberOfFutureTasks: futureOpen.count, todayClosedTask: justTodayClosed.count, todayAllTask: justTodayAll.count)
                                            .padding(.bottom)
                                            .padding(.bottom)
                                        
                                        
                                    }
                                }
                                
                                
                                // MARK: GEÇMİŞ
                                Group {
                                    if beforeTodayOpen.count > 0 {
                                        
                                        
                                        TitleView(title: "Geçmiş", number1: beforeTodayOpen.count, number2: 0, barShown: false, isTwoNumber: false)
                                        
                                        // BUGÜN YAPILACAKLAR
                                        ForEach(beforeTodayOpen) { task in
                                            ListRowItemView(homeData: task) {
                                                homeData.editItem(item: task)
                                            } editAction: {
                                                homeData.editItem(item: task)
                                            } deleteAction: {
                                                context.delete(task)
                                                NotificationManager.istance.cancelNotification(idArray: ["\(task.content!)"])
                                            }
                                            
                                        }
                                        
                                        Spacer(minLength: 15)
                                        
                                    }
                                }
                                
                                // MARK: BUGÜN
                                Group {
                                    
                                    TitleView(title: "Bugün", number1: justTodayClosed.count, number2: justTodayAll.count, barShown: true, isTwoNumber: true)
                                    //                                    .padding(.top, 20)
                                    
                                    if justTodayClosed.count > 0 && justTodayOpen.count == 0 {
                                        
                                        
                                        // TEBRİKLER TÜM GÖREVLERİ TAMAMLADIN
                                        EmptyTodayTaskView(isCongratz: true) {
                                            homeData.isNewData.toggle()
                                            homeData.content = ""
                                            homeData.updateItem = nil
                                            homeData.completion = false
                                            homeData.date = Date(timeIntervalSinceNow: 3600)
                                            homeData.isRemindMe = false
                                            
                                        }
                                        .animation(.spring())
                                        .padding(.horizontal)
                                    }
                                    else if justTodayClosed.count == 0 && justTodayOpen.count == 0 {
                                        // BUGÜN HİÇ TASK EKLEMEDİN
                                        EmptyTodayTaskView(isCongratz: false) {
                                            homeData.isNewData.toggle()
                                        }
                                        .animation(.spring())
                                        .padding(.horizontal)
                                    }
                                    else if justTodayOpen.count > 0 {
                                        
                                        
                                        // BUGÜN YAPILACAKLAR
                                        ForEach(justTodayOpen) { task in
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
                                    
                                    if justTodayClosed.count > 0 {
                                        
                                        if isJustTodayOpenShown {
                                            
                                            // BUGÜN KAPANANLAR
                                            ForEach(justTodayClosed) { task in
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
                                            isJustTodayOpenShown.toggle()
                                            haptics.impactOccurred()
                                        }, label: {
                                            HStack {
                                                Text(!isJustTodayOpenShown ? "Tamamlananları Göster" : "Tamamlananları Gizle")
                                                    .font(.system(.subheadline, design: .rounded))
                                                Image(systemName: !isJustTodayOpenShown ? "chevron.down" : "chevron.up")
                                            }
                                            .animation(.easeIn)
                                            .foregroundColor(.secondary)
                                            .padding()
                                        })
                                        
                                    }
                                }
                                
                                // MARK: GELECEK
                                Group {
                                    if futureOpen.count > 0 {
                                        
                                        
                                        TitleView(title: "Gelecek", number1: futureOpen.count, number2: 0, barShown: false, isTwoNumber: false)
                                            .padding(.top, 20)
                                        
                                        // GELECEK YAPILACAKLAR
                                        ForEach(futureOpen) { task in
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
                                }
                                
                            }
                            
                        })
                        
                    }
                    
                } // END OF MAIN VSTACK
                
                .onAppear(){ UITableView.appearance().backgroundColor = UIColor.clear }
                .background(EmptyView().sheet(isPresented : $homeData.isNewData) {NewDataView(homeData: homeData)})
                .opacity(selectedTab == "home" ? 1 : 0)
                .padding(.bottom)
                .padding(.bottom)
                .blur(radius: $isFirstTimeUsingApp.wrappedValue ? 5 : 0, opaque: false)
                
                // MARK: POPUP
                if $isFirstTimeUsingApp.wrappedValue {
                    WelcomeMessageView(isFirstTimeUsingApp: $isFirstTimeUsingApp)
                }
                
            }
            .ignoresSafeArea()
            .onAppear { UIApplication.shared.applicationIconBadgeNumber = 0 }
            .background(Utils.isDarkMode ? Color.black : Color.white)

            
            .cornerRadius(isShowingSideMenu ? 20 : 10)
            .scaleEffect(isShowingSideMenu ? 0.8 : 1)
            .offset(x: isShowingSideMenu ? 300.0 : 0, y: isShowingSideMenu ? 44 : 0)
            
            
            // SETTINGS VIEW
            SettingsMainView(selectedTab: $selectedTab)
                .opacity(selectedTab == "settings" ? 1 : 0)
        
        
        }
        
    }
    
    
    
    // MARK: FUNCTIONS
    
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { results[$0] }.forEach(context.delete)
            
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    private func deleteAll(){
        
        for item in closedTasks {
            context.delete(item)
        }
        
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}



/*
 
 
 
 
 
 
 
 
 // SETTINGS VIEW
 SettingsMainView(selectedTab: $selectedTab)
     .opacity(selectedTab == "settings" ? 1 : 0)
 
 
 
 // MARK: CUSTOM TAB BAR
 if isFirstTimeUsingApp == false {
 CustomTabBarView(
     action: {
         homeData.isNewData.toggle()
         homeData.content = ""
         homeData.updateItem = nil
         homeData.completion = false
         homeData.date = Date(timeIntervalSinceNow: 3600)
         homeData.isRemindMe = false
         
     },
     selectedTab: $selectedTab
 )
 
 }
 
 
 
 
 */

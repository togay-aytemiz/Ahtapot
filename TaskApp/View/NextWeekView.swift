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
    
    
    // TABBAR DEĞİŞİMİ İÇİN STATE
    @Binding var selectedTab: String
    
    
    // FETCHING DETAILS
    @Environment(\.managedObjectContext) var context
    
    
    // FETCH REQUESTLER BURAYA EKLENECEK
    
    
    // Shopping View
    @FetchRequest(entity: Shopping.entity(),sortDescriptors: [NSSortDescriptor(key: "date",ascending: false)],predicate: .OpenTasks(), animation: .spring()) var openShoppingListItem : FetchedResults<Shopping>
    
    
    
    
    // OTHER DETAILS
    let haptics = UIImpactFeedbackGenerator()
    
    
    @State private var isShowingSideMenu = false
    
    
    var showingDate : Date {
        var dateComponents1 = DateComponents()
        dateComponents1.setValue(1, for: .day)
        let tomorrow = Calendar.current.date(byAdding: dateComponents1, to: Calendar.current.startOfDay(for: Date()))!
        return tomorrow
        
    }
    
    
    
    
    // MARK: BODY
    var body: some View {
        ZStack{
            
            if isShowingSideMenu {
                SideMenuView(isShowingSideMenu: $isShowingSideMenu, selectedTab: $selectedTab)
            }
            
            ZStack {
                VStack{
                    // MARK: HEADER
                    CustomNavigationBarView(showDate: false, shoppingItem: openShoppingListItem.count, customNavigationHeader: "Sonraki 7 Gün", isShowingSideMenu: $isShowingSideMenu, description: homeData.findNextWeekDates())
                        .background(Utils.isDarkMode ? Color.black : Color.white)
                    
                    
                    
                    Spacer()
                    
                    
                    
                }
                
                
                
                
            }
            .edgesIgnoringSafeArea(.bottom)
            .onAppear { UIApplication.shared.applicationIconBadgeNumber = 0 }
            .background(Utils.isDarkMode ? Color.black : Color.white)
            
            // SIDE MENU ACTIONS
            .cornerRadius(isShowingSideMenu ? 20 : 0)
            .scaleEffect(isShowingSideMenu ? 0.8 : 1)
            .offset(x: isShowingSideMenu ? (UIScreen.screenWidth / 5 * 3) : 0, y: isShowingSideMenu ? (UIScreen.screenHeight / 20) : 0)
            .shadow(color: Color.black.opacity(isShowingSideMenu ? 0.2 : 0), radius: 8, x: -5, y: 5 )
            .disabled(isShowingSideMenu)
            
        }
        
        
        
    }
}



// MARK: PREVIEW
struct NextWeekView_Previews: PreviewProvider {
    static var previews: some View {
        NextWeekView(selectedTab: .constant("next7days"))
    }
}

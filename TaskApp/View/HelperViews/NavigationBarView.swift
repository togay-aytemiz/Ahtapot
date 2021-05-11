//
//  NavigationBarView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 23.04.2021.
//

import SwiftUI

struct NavigationBarView: View {
    // MARK: PROPERTIES

    @EnvironmentObject var obj: observed
    // @StateObject var homeData = HomeViewModel()
    
    var title : String = "Ahtapot"

    let haptics = UIImpactFeedbackGenerator()
    var showDate: Bool = true
    // var action: () -> Void
    
    var shoppingIcon: Bool = false
    var searchIcon: Bool = false
    var shoppingItem: Int = 1
    var appIconShow: Bool = false
    
    @State private var shoppingListOpen = false
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false

    
    // FETCHING DETAILS
    @Environment(\.managedObjectContext) var context
    
    // Fetch All Tasks
    @FetchRequest(
        entity: Task.entity(),
        sortDescriptors: [NSSortDescriptor(key: "date",ascending: true)],
        animation: .spring())
    var results : FetchedResults<Task>
    
    
    @State var activeSheet: ActiveSheet?
//    var actionSearch : () -> Void
//    var actionShoppingList: () -> Void
    
    
    
    
    
    
    
    
    // MARK: BODY
    var body: some View {
        HStack(spacing: 0){
            
            //TITLE
            HStack{
                if appIconShow {
                    Image("iconColorized")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                }
                
                
                    
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.heavy)
                        .foregroundColor(Utils.isDarkMode ? Color.white : Color.black)
                    if showDate {
                    Text(Date(), formatter: LongDateFormat)
                        .font(.system(.subheadline, design: .rounded))
                        .fontWeight(.semibold)
                        .foregroundColor(Color.secondary)
                    }
                }
            }
           
            
            Spacer()
            
            if searchIcon {
                Button(action: {
                    //searchOpen.toggle()
                    //actionSearch()
                    activeSheet = .first
                    haptics.impactOccurred()
                }, label: {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 24, weight: .light, design: .rounded))
                    
                })
                .foregroundColor(Color.primary.opacity(0.8))
                .disabled(results.count == 0)
                .opacity(results.count == 0 ? 0.4 : 1)
            }
            
            
            
            
            
        }
        .background(EmptyView().sheet(isPresented : $shoppingListOpen) {ShoppingListView()})
        .background(isDarkMode ? Color.black : Color.white).edgesIgnoringSafeArea(.all)
    }
}

// MARK: PREVIEW
struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarView()
            .previewLayout(.sizeThatFits)
    }
}



enum ActiveSheet: Identifiable {
    case first, second
    
    var id: Int {
        hashValue
    }
}




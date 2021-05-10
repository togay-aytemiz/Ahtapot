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
    @State private var searchOpen = false
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
                    searchOpen.toggle()
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
            
            
            if shoppingIcon {
                
                ZStack(alignment: .topTrailing) {
                    
                    Button(action: {
                        shoppingListOpen.toggle()
                        //actionShoppingList()
                        activeSheet = .second
                        haptics.impactOccurred()
                    }, label: {
                        Image(systemName: "cart")
                            .font(.system(size: 24, weight: .light, design: .rounded))
                        
                    })
                    .padding()
                    .foregroundColor(Color.primary.opacity(0.8))
                    
                    
                    
                    if shoppingItem > 0 {
                        Text("\(shoppingItem)")
                            .font(.footnote)
                            .padding(6)
                            .background(Color.red)
                            .clipShape(Circle())
                            .foregroundColor(.white)
                            
                            .offset(x: -5, y: 5)
                        
                    }
                }
                .animation(.spring())
                
            }
            
            
        }
//        .fullScreenCover(isPresented: $shoppingListOpen, content: {
//            ShoppingListView()
//        })
//        .sheet(isPresented: $searchOpen, content: {
//            SearchView().environmentObject(obj)
//        })
//        .background(EmptyView().sheet(isPresented: $shoppingListOpen) {
//            ShoppingList()
//        }.background(EmptyView().sheet(isPresented: $searchOpen) {
//            SearchView
//        }))
        
        .background(EmptyView().sheet(isPresented : $shoppingListOpen) {ShoppingListView()}.background(EmptyView().sheet(isPresented : $searchOpen) {SearchView().environmentObject(obj)}))
        

        
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




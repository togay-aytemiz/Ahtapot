//
//  CustomNavigationBarView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 10.05.2021.
//

import SwiftUI

struct CustomNavigationBarView: View {
    // MARK: PROPERTIES
    
    
    
    let haptics = UIImpactFeedbackGenerator()
    var showDate: Bool = true
    
    var shoppingIcon: Bool = true
    var shoppingItem: Int = 1
    
    @State private var shoppingListOpen = false
    
    var CustomNavigationHeaderIsShow = true
    var customNavigationHeader = "Bugün"
    
    @Binding var isShowingSideMenu: Bool
    
    
    // MARK: BODY
    var body: some View {
        ZStack(alignment: .center) {
            
            
            
            
            // HEADER
            VStack{
                
                if CustomNavigationHeaderIsShow {
                    Text(customNavigationHeader)
                        .font(.system(.headline, design: .rounded))
                        .fontWeight(.bold)
                }
                
                if showDate {
                Text(Date(), formatter: LongDateFormat)
                    .font(.system(.footnote, design: .rounded))
                    .fontWeight(.light)
                    .foregroundColor(Color.secondary)
                }
            }
            
            
            
            // ICONS
            HStack{
                
                
                // MARK: MENU ICON
                HStack{
                    Button(action: {
                        withAnimation(.spring()) {
                            isShowingSideMenu.toggle()
                            haptics.impactOccurred()
                        }
                    }, label: {
                        Image(systemName: "text.alignleft")
                            .font(.system(size: 24, weight: .light, design: .rounded))
                            .padding(.trailing)
                            .foregroundColor(Color.primary.opacity(0.8))
                    })
                    .padding()
                    
                    Spacer()
                        
                }
                
                
                
                Spacer()
                
                
                
                // MARK: SHOPPING CAR ICON
                if shoppingIcon {
                    
                    ZStack(alignment: .topTrailing) {
                        
                        Button(action: {
                            shoppingListOpen.toggle()
                            //actionShoppingList()
                            //activeSheet = .second
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
            
        }
        .background(EmptyView().sheet(isPresented : $shoppingListOpen) {ShoppingListView()})
        
        .padding(.top,1)
        .padding(.bottom, -10)

    }
}



// MARK: PREVIEW
struct CustomNavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationBarView(isShowingSideMenu: .constant(false))
            .previewLayout(.sizeThatFits)
            //.padding()
    }
}

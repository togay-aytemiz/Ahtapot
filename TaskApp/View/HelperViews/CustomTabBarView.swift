//
//  CustomTabBarView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 23.04.2021.
//

import SwiftUI

struct CustomTabBarView: View {
    // MARK: PROPERTIES
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    // COLORS
    @AppStorage("appColor1") private var AppColor1: String = "Color1A"
    @AppStorage("appColor2") private var AppColor2: String = "Color1B"

    @StateObject var homeData = HomeViewModel()
    let haptics = UIImpactFeedbackGenerator()
    var action: () -> Void
    
    
    @Binding var selectedTab: String
    
    
    // Animation Namespace for sliding effetc...
    @Namespace var animation
    

    
    // MARK: BODY
    var body: some View {
        HStack(alignment: .center){
            
            
            TabBarButton(animation: animation, image: "home", selectedTab: $selectedTab)
            
            //TabBarButton(animation: animation, image: "magnifingglass", selectedTab: $selectedTab)
                
            
            // ADD BUTTON
            ZStack {
                
                
                
                
                Button(action: {
                    haptics.impactOccurred()
                    action()
                }, label: {
                    Utils.AppThemeBackgroundColor
                        .mask(Image(systemName: "plus.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        ).frame(width: 60, height: 60, alignment: .center)
                })
                .background(Color.white)
                .clipShape(Circle())
                .shadow(color: Color(AppColor1).opacity(0.3), radius: 8, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 6.0)
                
                
                
            }
            .offset(y: -20)
            
            
            TabBarButton(animation: animation, image: "settings", selectedTab: $selectedTab)

            
        }
        //.padding(.top)
        // decreasing the extra padding added...
        .padding(.vertical, -10)
        .padding(.bottom, getSafeArea().bottom == 0 ? 15 : 0)
        .background(isDarkMode ? Color.black : Color.white)
        
        


       
    }
}



// extening view to get safe area
extension View {
    func getSafeArea() -> UIEdgeInsets {
        return UIApplication.shared.windows.first?.safeAreaInsets ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

struct TabBarButton: View {
    
    // COLORS
    @AppStorage("appColor1") private var AppColor1: String = "Color1A"
    @AppStorage("appColor2") private var AppColor2: String = "Color1B"

    
    var animation: Namespace.ID
    var image: String
    @Binding var selectedTab: String
    let haptics = UIImpactFeedbackGenerator()

    
    
    var body: some View {
        
        

        
        Button(action: {
            withAnimation(.spring()) {
                selectedTab = image
            }
            haptics.impactOccurred()

            
        }, label: {
            VStack(spacing: 6) {
                Image(image)
                    .resizable()
                    // because its asset image
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(selectedTab == image ? Color(AppColor1) : Color.gray.opacity(0.4))
                
                if selectedTab == image {
                    Circle()
                        .fill(Color(AppColor1))
                        // sliding effect
                        .matchedGeometryEffect(id: "TAB", in: animation)
                        .frame(width: 8, height: 8)
                }
            }
            .frame(maxWidth: .infinity)
          
            
        })
        
    }
   
    
}

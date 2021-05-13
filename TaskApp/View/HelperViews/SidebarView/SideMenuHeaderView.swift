//
//  SideMenuHeaderView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 10.05.2021.
//

import SwiftUI

struct SideMenuHeaderView: View {
    // MARK: PROPERTIES
    
    @StateObject var homeData = HomeViewModel()

    @Binding var isShowingSideMenu: Bool
    
    // MARK: BODY
    var body: some View {
        
        
        VStack{
            
            // MARK: ICONS & APP NAME
            HStack(spacing: 15) {
                
                Text(homeData.getTimeOfTheDay())
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.heavy)
                    .foregroundColor(Color.white)
                    .padding(.leading)
                
                
                Spacer()
                
                Button(action: {
                    withAnimation(.spring()) {
                        isShowingSideMenu.toggle()
                    }
                }, label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 24, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                        .padding()
                })
            }

        }
        .padding()
    }
}



// MARK: PREVIEW
struct SideMenuHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        
        SideMenuHeaderView(isShowingSideMenu: .constant(true))
                .previewLayout(.sizeThatFits)
                .padding()
                .background(Utils.AppThemeBackgroundColor.edgesIgnoringSafeArea(.all))
        
    }
}

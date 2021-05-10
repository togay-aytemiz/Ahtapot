//
//  SideMenuView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 10.05.2021.
//

import SwiftUI

struct SideMenuView: View {
    // MARK: PROPERTIES
    
    @Binding var isShowingSideMenu: Bool
    @Binding var selectedTab: String
    
    // MARK: BODY
    var body: some View {
        ZStack{

            Utils.AppThemeBackgroundColor.edgesIgnoringSafeArea(.all)
            
            
            VStack(alignment: .leading){
                
                //HEADER
                SideMenuHeaderView(isShowingSideMenu: $isShowingSideMenu)
                
                Spacer()
                
                //OPTIONS
                
                ForEach(SideMenuViewModel.allCases, id:\.self) { options in
                    Button(action: {
                        withAnimation(.spring()) {
                            selectedTab = options.title
                        }
                    }, label: {
                        SideMenuOptionView(viewmodel: options)
                    })
                    
                }
                
                Spacer()
                Spacer()
            }
            
            
        }
    }
}


// MARK: PREVIEW
struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(isShowingSideMenu: .constant(false), selectedTab: .constant("home"))
    }
}

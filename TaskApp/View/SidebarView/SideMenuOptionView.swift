//
//  SideMenuOptionView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 10.05.2021.
//

import SwiftUI

struct SideMenuOptionView: View {
    // MARK: PROPERTIES
    
    let viewmodel: SideMenuViewModel
    var isSelectedTab: Bool = true
    
    // MARK: BODY
    var body: some View {
        HStack {
            HStack{
                Image(systemName: viewmodel.imageName)
                    .frame(width: 24, height: 24)
                
                Text(viewmodel.title)
                    .font(.system(.headline, design: .rounded))
                    .fontWeight(.semibold)
            }
            .padding()
            .foregroundColor(.white)
            
            Spacer()
        }
        .background(Color.white.opacity(isSelectedTab ? 0.2 : 0).edgesIgnoringSafeArea(.all))
        
        
        
    }
}



// MARK: PREVIEW
struct SideMenuOptionView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuOptionView(viewmodel: .homepage)
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Utils.AppThemeBackgroundColor.edgesIgnoringSafeArea(.all))
    }
}

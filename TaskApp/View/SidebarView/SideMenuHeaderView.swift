//
//  SideMenuHeaderView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 10.05.2021.
//

import SwiftUI

struct SideMenuHeaderView: View {
    // MARK: PROPERTIES
    
    
    @Binding var isShowingSideMenu: Bool
    
    // MARK: BODY
    var body: some View {
        
        
        VStack{
            
            // MARK: ICONS & APP NAME
            HStack(spacing: 15) {
                Image("iconSmall")
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(width: 64, height: 64)
                
                VStack(alignment: .leading){
                    Text("Ahtapot")
                        .font(.system(.title2, design: .rounded))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    
                    Text("Kişisel asistanın")
                        .font(.system(.headline, design: .rounded))
                            .fontWeight(.light)
                            .foregroundColor(.white)
                }
                
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
            
            
            // maybe some basic stats here
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

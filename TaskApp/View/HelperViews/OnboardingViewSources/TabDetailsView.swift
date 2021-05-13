//
//  TabDetailsView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 20.04.2021.
//

import SwiftUI

struct TabDetailsView: View {
    // MARK: PROPERTIES
    
    let index: Int
    
    
    
    
    // MARK: BODY
    var body: some View {
        VStack(spacing: 10) {
            
           
                
            Image(onboardingViewTabs[index].image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 300)
                .frame(maxWidth: 640)
                .minimumScaleFactor(0.5)
            
            
            
            Text(onboardingViewTabs[index].title)
                .font(.system(.title2, design: .rounded))
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .minimumScaleFactor(0.7)
                .fixedSize(horizontal: false, vertical: true)
            
            
            Text(onboardingViewTabs[index].text)
                .font(.headline)
                .fontWeight(.regular)
                .foregroundColor(Color.secondary)
                .padding(.horizontal)
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .minimumScaleFactor(0.7)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal)
                        
        } //VSTACK
        .frame(width: UIScreen.main.bounds.width - 30)
        .animation(.default)
        .foregroundColor(Color("Color1"))
//        .minimumScaleFactor(0.5)
        .padding(.bottom, 60)
    }
}


// MARK: PREVIEW
struct TabDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            TabDetailsView(index: 0)
                .environment(\.locale, .init(identifier: "en"))
        }
    }
}

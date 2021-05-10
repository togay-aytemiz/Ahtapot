//
//  PageTabView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 20.04.2021.
//

import SwiftUI
import UIKit

struct PageTabView: View {
    // MARK: PROPERTIES
    
    @Binding var selection: Int
    
    
    
    
    // MARK: BODY
    var body: some View {
        TabView(selection: $selection){
            ForEach(onboardingViewTabs.indices, id:\.self) { index in
                TabDetailsView(index: index)
                    .animation(.default)

            }
        }
        .tabViewStyle(PageTabViewStyle())
        .accentColor(Color("Color1"))
        .animation(.default)
        
        
    }
    
   
}


// MARK: PREVIEW
struct PageTabView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            PageTabView(selection: .constant(0))
        }
    }
}

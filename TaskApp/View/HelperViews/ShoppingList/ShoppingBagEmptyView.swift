//
//  ShoppingBagEmptyView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 29.04.2021.
//

import SwiftUI

struct ShoppingBagEmptyView: View {
    // MARK: PROPERTIES
    
    //@AppStorage("isDarkMode") private var isDarkMode: Bool = false

    
    // MARK: BODY
    var body: some View {
        
        
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                Image("shopping")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120)
                Spacer()
            }
            .padding()
            Text("Listen boş.\nAşağıdan ekleyebilirsin.")
                .font(.system(.title3, design: .rounded))
                .fontWeight(.light)
                .multilineTextAlignment(.center)
                .foregroundColor(Utils.isDarkMode ? Color.white.opacity(0.7) : Color.primary.opacity(0.8))
            Spacer()
        }
        .padding(.bottom, 40)
        
    }
}

// MARK: PREVIEW
struct ShoppingBagEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingBagEmptyView()
    }
}

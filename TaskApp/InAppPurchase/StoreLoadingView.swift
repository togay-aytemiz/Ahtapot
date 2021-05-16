//
//  StoreLoadingView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 16.05.2021.
//

import SwiftUI

struct StoreLoadingView: View {
    // MARK: PROPERTIES
    
    
    
    
    // MARK: BODY
    var body: some View {
        ZStack {
            
            Color.black.opacity(0.7).edgesIgnoringSafeArea(.all)
            
            VStack{
                
                
                Image("iconSmall")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                
                Text("loadingStateText".localized())
                    .font(.system(.title2, design: .rounded))
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                
                
            }
        }
    }
}


// MARK: PREVIEW
struct StoreLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        StoreLoadingView()
    }
}

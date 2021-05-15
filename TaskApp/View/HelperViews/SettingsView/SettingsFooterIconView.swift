//
//  SettingsFooterIconView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 15.05.2021.
//

import SwiftUI

struct SettingsFooterIconView: View {
    // MARK: PROPERTIES
    
    
    
    
    // MARK: BODY
    var body: some View {
        Group{
            VStack{
                
                Image("iconColorized")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                
                Text("Ahtapot")
                    .font(.system(.title2, design: .rounded))
                    .fontWeight(.heavy)
                    .foregroundColor(.primary)
                
                Text("brandSubheadline".localized())
                    .font(.system(.headline, design: .rounded))
                        .fontWeight(.light)
                        .foregroundColor(.secondary)
                
                Text(UIApplication.appVersion ?? "")
                    .font(.system(.footnote, design: .rounded))
                        .fontWeight(.light)
                        .foregroundColor(.secondary)
                
            }
            .padding()
            .padding(.vertical)
            .padding(.bottom, 20)
        }
    }
}



// MARK: PREVIEW
struct SettingsFooterIconView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsFooterIconView()
    }
}

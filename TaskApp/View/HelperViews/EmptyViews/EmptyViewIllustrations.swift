//
//  EmptyViewIllustrations.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 20.04.2021.
//

import SwiftUI

struct EmptyViewIllustrations: View {
    // MARK: PROPERTIES
    
    var image: String
    var text: String
    var header: String
    
    //@AppStorage("isDarkMode") private var isDarkMode: Bool = false

    
    // MARK: BODY
    var body: some View {
        
        VStack{
            Spacer()
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 300)
            
            
            VStack {
                Text(header)
                    .font(.system(.title2, design: .rounded))
                    .fontWeight(.heavy)
                    .padding(.bottom)

                Text(text)
                    .font(.system(.headline, design: .rounded))
                    .fontWeight(.light)
                    
            }
            .multilineTextAlignment(.center)
            .minimumScaleFactor(0.7)
            .lineLimit(3)
            .fixedSize(horizontal: false, vertical: true)
            .foregroundColor(Utils.isDarkMode ? Color.white.opacity(0.7) : Color.black.opacity(0.6))
            .padding(.top, -15)

            Spacer()
        }
        
        
    }
}


// MARK: PREVIEW
struct EmptyViewIllustrations_Previews: PreviewProvider {
    static var previews: some View {
        EmptyViewIllustrations(image: "NoSearchView", text: "Henüz hiç yapılacak şey eklememişsin\nHadi hemen ekleyelim... 💪🏻", header: "SONUÇ YOK")
            
            
    }
}

//
//  GiftRowView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 16.05.2021.
//

import SwiftUI

struct GiftRowView: View {
    // MARK: PROPERTIES
    
    
    
    
    // MARK: BODY
    var body: some View {
        
        HStack(spacing: 15) {
            Image("gift_small_01")
                .resizable()
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .frame(width: 40, height: 40, alignment: .center)
            
            VStack(alignment: .leading) {
                Text("Title")
                    .font(.system(.headline, design: .rounded))
                    .fontWeight(.semibold)
                    .foregroundColor(Utils.isDarkMode ? .white : .black)
                
                
                Text("Description")
                    .font(.system(.body, design: .rounded))
                    .fontWeight(.regular)
                    .foregroundColor(Utils.isDarkMode ? .white : .black)
                    .opacity(0.7)
                    .lineLimit(2)
                    .minimumScaleFactor(0.1)
                    .fixedSize(horizontal: false, vertical: true)

                
            
                
            }
            
            Spacer()
            
            
            //price
            Text("$9.99")
                .font(.system(.title3, design: .rounded))
                .fontWeight(.heavy)
                .foregroundColor(Utils.isDarkMode ? .white : .black)
            
        }
        .padding()
        .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Utils.isDarkMode ? Color.white : Color.gray, lineWidth: 0.5 )
            )
        
    }
}



// MARK: PREVIEW
struct GiftRowView_Previews: PreviewProvider {
    static var previews: some View {
        GiftRowView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

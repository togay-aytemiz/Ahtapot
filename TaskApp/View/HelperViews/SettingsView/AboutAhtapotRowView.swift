//
//  AboutAhtapotRowView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 15.05.2021.
//

import SwiftUI

struct AboutAhtapotRowView: View {
    // MARK: PROPERTIES
    
    var isIconShow: Bool
    var icon : String
    var color: Color 
    
    
    var text: String
    var secondText = ""
    
    var descriptionText: String
    
    var isNewPageOpen: Bool
    
    var action: () -> Void
    
    
    
    // MARK: BODY
    var body: some View {
        VStack {
            
            Divider().padding(.vertical, 4)
            
            HStack{
                
                if isIconShow {
                    ZStack{
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(color).opacity(0.7)
                            .shadow(color: color.opacity(0.6), radius: 8, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 6.0)

                        Image(systemName: icon)
                            .imageScale(.medium)
                            .foregroundColor(.white)
                        
                    }
                    .frame(width: 36, height: 36, alignment: .center)
                }
                
                
                VStack(alignment: .leading) {
                    Text(text)
                        .padding(.leading, 6)
                        .foregroundColor(.primary)
                    
                    if secondText != ""{
                        Text(secondText)
                            .padding(.leading, 6)
                            .foregroundColor(.secondary)
                    }
                }

                Spacer()
                
                if descriptionText != "" {
                Text(descriptionText)
                    .padding(.leading, 6)
                    .foregroundColor(.secondary)
                
                }
                
                if isNewPageOpen {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                        .accentColor(Color(.systemGray2))
                }
                
                
            }
        }
    }
}


// MARK: PREVIEW
struct AboutAhtapotRowView_Previews: PreviewProvider {
    static var previews: some View {
        AboutAhtapotRowView(isIconShow: true, icon: "heart.fill", color: .red, text: "SomeText", descriptionText: "someDescription", isNewPageOpen: true) {
            // some action
        }
        .previewLayout(.sizeThatFits)
        
    }
}

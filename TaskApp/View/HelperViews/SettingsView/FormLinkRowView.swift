//
//  FormLinkRowView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 24.04.2021.
//

import SwiftUI


struct FormLinkRowView: View {
    // MARK: PROPERTIES
    
    var icon : String
    var color: Color
    var text: String
    
    var action: () -> Void
    
    //@AppStorage("isDarkMode") private var isDarkMode: Bool = false


    // MARK: BODY
    var body: some View {
        
        Button(action: {
            action()
        }, label: {
            VStack {
                Divider().padding(.vertical, 4)

                HStack {
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(color).opacity(0.7)
                            .shadow(color: color.opacity(0.6), radius: 8, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 6.0)

                        Image(systemName: icon)
                            .imageScale(.medium)
                            .foregroundColor(.white)
                        
                    }
                    .frame(width: 36, height: 36, alignment: .center)
                    
                    Text(text)
                        .padding(.leading, 6)
                        .foregroundColor(.primary)

                    Spacer()
                    
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                        .accentColor(Color(.systemGray2))
                    
                }
            }
        })
        
        
    }
}

struct FormLinkRowView_Previews: PreviewProvider {
    static var previews: some View {
        FormLinkRowView(icon: "globe", color: Color.pink, text: "Website") {
            //
        }
        .previewLayout(.sizeThatFits)
        .padding()
                    
    }
}
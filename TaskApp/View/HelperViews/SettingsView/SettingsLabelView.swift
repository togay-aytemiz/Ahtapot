//
//  SettingsLabelView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 24.04.2021.
//

import SwiftUI

struct SettingsLabelView: View {
    // MARK: PROPERTIES
    
    // COLORS
    //@AppStorage("appColor1") private var AppColor1: String = "Color1A"
    //@AppStorage("appColor2") private var AppColor2: String = "Color1B"
    
    var labelText: String
    var labelImage: String
    var color: Color
    var gradientImage: Bool = true
    
    // MARK: BODY
    var body: some View {
        HStack {
            Text(labelText)
                .font(.system(.title3, design: .rounded))
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundColor(color)
                .lineLimit(1)
                .fixedSize(horizontal: false, vertical: true)
                .minimumScaleFactor(0.5)
            
            Spacer()
            
            if gradientImage {
                Utils.AppThemeBackgroundColor
                    .mask(Image(systemName: labelImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                          
                    )
                    .frame(width: 24, height: 24, alignment: .center)
                    .shadow(color: color.opacity(0.2), radius: 8, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 6.0)
            } else {
                Image(systemName: labelImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(color)

                    .frame(width: 24, height: 24, alignment: .center)
                    .shadow(color: color.opacity(0.2), radius: 8, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 6.0)
            }
            
            
            
            

        }
    }
}

struct SettingsLabelView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsLabelView(labelText: "Ahtapot", labelImage: "info.circle.fill", color: Color("Color1"))
            .previewLayout(.sizeThatFits)
            .padding()
        
    }
}

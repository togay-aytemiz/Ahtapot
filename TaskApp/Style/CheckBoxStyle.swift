//
//  CheckBoxStyle.swift
//  Devote
//
//  Created by Togay Aytemiz on 11.04.2021.
//

import SwiftUI

struct CheckBoxStyle: ToggleStyle {
    
    @State private var trimVal : CGFloat = 0
    
    // COLORS
    @AppStorage("appColor1") private var AppColor1: String = "Color1A"
    @AppStorage("appColor2") private var AppColor2: String = "Color1B"

    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    var completion: Color {
        if isDarkMode {
            return Color.white.opacity(0.5)
        } else {
            return Color.gray.opacity(0.3)
        }
    }
    
    
    let haptics = UIImpactFeedbackGenerator()

    func makeBody(configuration: Configuration) -> some View {
        return HStack{
            
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .foregroundColor(configuration.isOn ? completion : Color(AppColor1))
                .font(.system(size: 24, weight: .semibold, design: .rounded))
                .onTapGesture(perform: {
                    configuration.isOn.toggle()
                    haptics.impactOccurred()
                    

                })
            
            
            configuration.label
                .padding(.leading, 5)
            
            
            
        } // HSTACK
        
        
    }
}

struct CheckBoxStyle_Previews: PreviewProvider {
    static var previews: some View {
        Toggle(isOn: .constant(false), label: {
            Text("Placeholder Text")
        })
        .toggleStyle(CheckBoxStyle())
        .padding()
        .previewLayout(.sizeThatFits)
        
    }
}

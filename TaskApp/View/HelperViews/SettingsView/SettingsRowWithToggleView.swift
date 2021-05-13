//
//  SwttingsRowWithToggleView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 28.04.2021.
//

import SwiftUI

struct SettingsRowWithToggleView: View {
    // MARK: PROPERTIES
    
    var color: Color = Color(.blue)
    var image: String = "checkmark.square.fill"

    var text1 : String = "Uygulama Kullanımı"
    var text2 : String = "Sadece 2 dakika sürecek, söz 🙈"
    
    @Binding var toggleStatus: Bool
    
    // MARK: BODY
    var body: some View {
        
        
        VStack {
            
            Divider().padding(.vertical, 4)
            
            HStack {
                
                // MARK: BACKGROUND
                ZStack {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(color).opacity(0.7)
                        .shadow(color: color.opacity(0.4), radius: 8, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 6.0)

                    Image(systemName: image)
                        .foregroundColor(Color.white)
                    
                }
                .frame(width: 36, height: 36, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                
                // MARK: CONTENT
                VStack(alignment: .leading){
                    Text(text1)
                    
                    if !text2.isEmpty {
                        Text(text2)
                            .font(.system(.subheadline, design: .rounded))
                            .fontWeight(.light)
                            .foregroundColor(.primary)
                    }
                    
                }
                .padding(.leading, 6)
                
                Spacer()
                
                
                
                // MARK: TOGGLE
                Toggle(isOn: $toggleStatus, label: {
                    Text("")
                })
                .toggleStyle(SwitchToggleStyle(tint: color))
                .labelsHidden()
                .padding(.trailing, 4)

                
                
                
            }
            //.background(color.opacity(0.15))
            //.cornerRadius(8)
        }
        
        
        
    }
}


// MARK: PREVIEW
struct SwttingsRowWithToggleView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsRowWithToggleView(toggleStatus: .constant(true))
    }
}

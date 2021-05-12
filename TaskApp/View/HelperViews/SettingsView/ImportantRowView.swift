//
//  ImportantRowView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 24.04.2021.
//

import SwiftUI

struct ImportantRowView: View {
    // MARK: PROPERTIES
    
    //@AppStorage("isDarkMode") private var isDarkMode: Bool = false

    var color: Color = Color("ClosedTasksColorIcon")
    var color2: Color = Color(.white)
    
    var text1 : String = "Uygulama Kullanımı"
    var text2 : String = "Sadece 2 dakika sürecek, söz 🙈"
    
    var image: String = "checkmark.circle.fill"
    var rightIconShow: Bool = true
    
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    // MARK: BODY
    var body: some View {
        
        HStack{
            // Illustration
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(color).opacity(0.5)
                    .shadow(color: color.opacity(0.6), radius: 8, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 6.0)

                Image(systemName: image)
                    .foregroundColor(Color.white)
                
            }
            .frame(width: 36, height: 36, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

            VStack(alignment: .leading){
                Text(text1)
                    .font(.system(.headline, design: .rounded))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(isDarkMode ? .white : color)
                
                if !text2.isEmpty {
                    Text(text2)
                        .font(.system(.subheadline, design: .rounded))
                        .fontWeight(.light)
                        .foregroundColor(isDarkMode ? .white : color)
                }
                
            }
            .padding(.leading, 6)
            
            Spacer()
            
            
            
            
            
            // CHEVRON
            if rightIconShow {
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .foregroundColor(color)
            }
            
                
            
        }
        .padding()
        .background(color.opacity(0.15))
        .cornerRadius(8)
        
        
        
    }
}

struct ImportantRowView_Previews: PreviewProvider {
    static var previews: some View {
        ImportantRowView()
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

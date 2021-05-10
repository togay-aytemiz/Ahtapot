//
//  TutorialLinkView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 24.04.2021.
//

import SwiftUI

struct TutorialLinkView: View {
    // MARK: PROPERTIES
    
    
    var color: Color = .blue
    
    var text1 : String = "Uygulama Kullanımı"
    var text2 : String = "Sadece 2 dakika sürecek, söz 🙈"
    
    // MARK: BODY
    var body: some View {
             

            
            HStack{                
                // Illustration
                ZStack {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(color)
                    Image(systemName: "questionmark.circle.fill")
                        .foregroundColor(Color.white)
                    
                }
                .frame(width: 36, height: 36, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

                VStack(alignment: .leading){
                    Text(text1)
                        .font(.system(.headline, design: .rounded))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(color)
                    
                    if !text2.isEmpty {
                        Text(text2)
                            .font(.system(.subheadline, design: .rounded))
                            .fontWeight(.light)
                            .foregroundColor(color)
                    }
                    
                }
                .padding(.leading, 6)
                
                Spacer()
                
                // CHEVRON
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .foregroundColor(color)
                    
                
            }
            .padding()
            .background(color.opacity(0.1))
            .cornerRadius(8)
            
        
    }
}


// MARK: PREVIEW
struct TutorialLinkView_Previews: PreviewProvider {
    static var previews: some View {
        
        TutorialLinkView()
            .previewLayout(.sizeThatFits)
            .padding()
 
    }
}

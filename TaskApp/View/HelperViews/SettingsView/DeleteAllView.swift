//
//  DeleteAllView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 24.04.2021.
//

import SwiftUI

struct DeleteAllView: View {
    // MARK: PROPERTIES
    
    var color: Color = .red
    
    // MARK: BODY
    var body: some View {
        
        
        HStack{
            // Illustration
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(color)
                    .shadow(color: color.opacity(0.4), radius: 8, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 6.0)

                Image(systemName: "trash.fill")
                    .foregroundColor(Color.white)
                
            }
            .frame(width: 36, height: 36, alignment: .center)

            VStack(alignment: .leading){
                Text("deleteAllDataRowHeader".localized())
                    .font(.system(.headline, design: .rounded))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(color)
                
                Text("deleteAllDataRowBody".localized())
                    .font(.system(.subheadline, design: .rounded))
                    .fontWeight(.light)
                    .foregroundColor(color)
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
struct DeleteAllView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteAllView()
    }
}

//
//  GiftRowView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 16.05.2021.
//

import SwiftUI

struct GiftRowView: View {
    // MARK: PROPERTIES
    
    let gift: Gift
    
    let action: () -> Void
    
    // MARK: BODY
    var body: some View {
        
        HStack(alignment: .center, spacing: 15) {
            Image(gift.imageName!)
                .resizable()
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .frame(width: 40, height: 40, alignment: .center)
            
            VStack(alignment: .leading) {
                Text(gift.title.uppercased())
                    .font(.system(.footnote, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
                    .fixedSize(horizontal: false, vertical: true)
                
                
                Text(gift.price!)
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
  
            }
            
            Spacer()
            
            
            Button(action: {
                action()
            }, label: {
                Text("select".localized().uppercased())
                    .font(.system(.subheadline, design: .rounded))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 14)
                    
                    .cornerRadius(6)
                    .foregroundColor(Color(Utils.AppColor1))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(Utils.AppColor1), lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                    )
            })
            
            
            
            
        }
        .padding()
        .padding(.vertical,5)
        .padding(5)
        
        .background(Color(gift.imageName!))
        .cornerRadius(12)
        .padding(.horizontal)
        
    }
}

//
//
//// MARK: PREVIEW
//struct GiftRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        TipActionDetailView()
//    }
//}

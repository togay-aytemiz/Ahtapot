//
//  TitleView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 23.04.2021.
//

import SwiftUI

struct TitleView: View {
    // MARK: PROPERTIES
    
    
    @AppStorage("appColor1")  var AppColor1: String = "Color1A"
    @AppStorage("appColor2")  var AppColor2: String = "Color1B"
    
    
    var title: String
    var number1: Int
    var number2: Int
    
    
    var convertedNumber1: CGFloat {
        return CGFloat(number1)
    }
    
    var convertedNumber2: CGFloat {
        return CGFloat(number2)
    }
    
    // SOME FEATURES
    var barShown: Bool
    var isTwoNumber: Bool
    
    // her 2 sayı da sıfırsa bar'ın gri olması
    var isNumber1Zero: LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(Utils.isDarkMode ? 0.5 : 0.15), Color.gray.opacity(Utils.isDarkMode ? 0.5 : 0.15)]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
    }
    
    
   
    var animation: Animation {
        Animation.spring()
    }
    
    
    
    
    // MARK: BODY
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                
                    
                Text(title)
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.heavy)
                    .foregroundColor(Utils.isDarkMode ? Color.white.opacity(0.8) : Color.black.opacity(0.8))
                
                
                Spacer()
                
                
                HStack(spacing: 2){
                    Text("\(number1)")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.heavy)
                        .foregroundColor(Color(Utils.AppColor1))
                    
                    if isTwoNumber {
                        Text("/")
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.heavy)
                            .foregroundColor(Color(Utils.AppColor1))
                        
                        Text("\(number2)")
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.heavy)
                            .foregroundColor(Color(Utils.AppColor1))
                    }
                    
                }
            } // MARK: - hstack
            
            if barShown {
                withAnimation(.easeInOut) {
                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            
                            
                            Rectangle()
                                .fill(Color.gray).opacity(Utils.isDarkMode ? 0.5 : 0.15)
                                .frame(height: 6)
                                .clipShape(Capsule())
                            
                            Rectangle()
                                .fill(number1 == 0 ? isNumber1Zero : LinearGradient(gradient: Gradient(colors: [Color(AppColor1), Color(AppColor2)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                .frame(width: ((geo.size.width / convertedNumber2 * convertedNumber1 )), height: 6)
                                .clipShape(Capsule())
                                .animation(.default)

                            
                        }
                    }
                    .animation(.default)
                    .frame(height: 10)
                }
            }
            
            
            
        } // MARK: VSTACK
        .padding(.horizontal)
        .padding(.top, 15)
        .padding(.bottom,10)
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(title: "Bugün", number1: 3, number2: 10, barShown: true, isTwoNumber: false)
            .previewLayout(.sizeThatFits)
    }
}

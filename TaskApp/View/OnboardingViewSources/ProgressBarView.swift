//
//  ProgressBarView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 21.04.2021.
//

import SwiftUI

struct ProgressBarView: View {
    // MARK: PROPERTIES
    
    @Binding var selection: Int
    
    // COLORS
    @AppStorage("appColor1") private var AppColor1: String = "Color1A"
    @AppStorage("appColor2") private var AppColor2: String = "Color1B"
    
    var calculatedSelection: CGFloat {
        return CGFloat(selection) + 1.0
    }
    
    // MARK: BODY
    var body: some View {
        
        
        
        withAnimation(.easeInOut) {
            GeometryReader { geo in
                ZStack{
                    
                    
                    Rectangle()
                        .fill(Color.gray).opacity(0.15)
                        .frame(height: 4)
                        .clipShape(Capsule())
                    
                    Rectangle()
                        .fill(Utils.AppThemeBackgroundColor)
                        .frame(width: ((geo.size.width / CGFloat(onboardingViewTabs.count)) * calculatedSelection), height: 4)
                        .clipShape(Capsule())
                        .animation(.default)

                    
                    
                    
                }
            }
            .animation(.default)
            .frame(height: 10)
            .frame(maxWidth: 640)
        }
        
        //SELECTION
//        withAnimation {
//            ZStack {
//
//                GeometryReader { geo in
//                    Rectangle()
//                        .fill(Color.gray).opacity(0.3)
//                        .frame(width: geo.size.width,  height: 10)
//                        .clipShape(Capsule())
//                }
//
//
//                GeometryReader { geo in
//                    Rectangle()
//                        .fill(Color("Color1"))
//                        .frame(width: ((geo.size.width / 3) * calculatedSelection),  height: 10)
//                        .clipShape(Capsule())
//                }
//            }
//        }
        
    }
}


// MARK: PREVIEW
struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView(selection: .constant(0))
            .previewLayout(.sizeThatFits)
            .padding()
            
    }
}

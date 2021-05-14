//
//  MiniAddTaskButtonView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 11.05.2021.
//

import SwiftUI

struct MiniAddTaskButtonView: View {
    // MARK: PROPERTIES
    
    let haptics = UIImpactFeedbackGenerator()
    var action: () -> Void
    
    
    // MARK: BODY
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                Button(action: {
                    haptics.impactOccurred()
                    action()
                }, label: {
                    Utils.AppThemeBackgroundColor
                        .mask(Image(systemName: "plus.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        ).frame(width: 60, height: 60, alignment: .center)
                })
                .background(Color.white)
                .clipShape(Circle())
                .shadow(color: Color(Utils.AppColor1).opacity(0.3), radius: 8, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 6.0)
                .padding()
                
                
                
            }
        }
    }
}



// MARK: PREVIEW
struct MiniAddTaskButtonView_Previews: PreviewProvider {
    static var previews: some View {
        MiniAddTaskButtonView(action: {
            //
        })
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

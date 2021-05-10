//
//  addTaskButton.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 19.04.2021.
//

import SwiftUI

struct addTaskButton: View {
    // MARK: PROPERTIES
    
    @StateObject var homeData = HomeViewModel()
    let haptics = UIImpactFeedbackGenerator()

    var action: () -> Void
    
    // COLORS
    @AppStorage("appColor1") private var AppColor1: String = "Color1A"
    @AppStorage("appColor2") private var AppColor2: String = "Color1B"
    
    
    // MARK: BODY
    var body: some View {
        ZStack {
            
            Button(action: {
                haptics.impactOccurred()
                action()
            }, label: {
                Image(systemName: "plus.circle.fill")
                    .font(.system(.title2, design: .rounded))
                Text("Yeni Görev Ekle")
                    .font(.system(.headline, design: .rounded))
            })
            .foregroundColor(.white)
            .padding(.horizontal, 20)
            .padding(.vertical, 15)
            .background(Utils.AppThemeBackgroundColor)
            .clipShape(Capsule())
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 8, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 4.0)
            .padding(30)
            
        }
    }
}


// MARK: PREVIEW
struct addTaskButton_Previews: PreviewProvider {
    static var previews: some View {
        addTaskButton(action: {
            //
        })
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

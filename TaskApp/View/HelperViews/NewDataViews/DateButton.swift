//
//  DateButton.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 18.04.2021.
//

import SwiftUI

struct DateButton: View {
    // MARK: PROPERTIES
    
    var title: String
    @ObservedObject var homeData: HomeViewModel

    
    
    let haptics = UIImpactFeedbackGenerator()

    

    var unselectedBackground: LinearGradient {
        if Utils.isDarkMode {
            return Utils.backgroundGradientDark
        } else {
            return Utils.backgroundGradientLightGray
        }
    }
    
    var unselectedFontColor: Color {
        if Utils.isDarkMode {
            return Color(UIColor.systemGray2)
        } else {
            return .secondary
        }
    }
    
    // MARK: BODY
    var body: some View {
        Button(action: {
            homeData.updateDate(value: title)
            haptics.impactOccurred()

        }, label: {
            Text(title)
                .font(.system(.subheadline, design: .rounded))
                .fontWeight(.light)
                .padding(.vertical, 6)
                .padding(.horizontal, 14)
                .background(homeData.checkDate() == title ? Utils.AppThemeBackgroundColor : unselectedBackground)
                .cornerRadius(6)
                .foregroundColor(homeData.checkDate() == title ? .white : Color(Utils.AppColor1) )
            
            
        })
    }
}



struct DateButton_Previews: PreviewProvider {
    static var previews: some View {
        DateButton(title: "Button", homeData: HomeViewModel())
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

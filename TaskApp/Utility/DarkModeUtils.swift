//
//  DarkModeUtils.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 3.05.2021.
//

import SwiftUI

struct Utils {
        
    @AppStorage("themeMode") static var currentTheme = 0
    @AppStorage("isDarkMode") static var isDarkMode: Bool = false
    @AppStorage("isBasicStatView") static var isBasicStatView: Bool = true
    
    
    // SOME COLORS
    @AppStorage("appColor1") static var AppColor1: String = "Color1A"
    @AppStorage("appColor2") static var AppColor2: String = "Color1B"
    
    
    
    static var AppThemeBackgroundColor: LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [Color(Utils.AppColor1), Color(Utils.AppColor2)]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    
    static var backgroundGradientWhite: LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [Color.white, Color.white]), startPoint: .leading, endPoint: .trailing)
    }

    static var backgroundGradientLightGray: LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [Color("ColorLightGray"), Color("ColorLightGray")]), startPoint: .leading, endPoint: .trailing)
    }

    static var backgroundGradientDark: LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [Color("ColorDarkButton"), Color("ColorDarkButton")]), startPoint: .leading, endPoint: .trailing)
    }
    
    static var backgroundGradientBlack: LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [Color.gray, Color.gray]), startPoint: .leading, endPoint: .trailing)
    }
    
    

}



/*
 
 
 struct Utils:
 enum AppTheme: Int {
 case unspecified = 0
 case light
 case dark
 }
 
 static func title() -> String {
 switch Utils.currentTheme {
 case 1:
 return "Açık"
 case 2:
 return "Koyu"
 default:
 return"Sistem"
 }
 }
 
 static func changeTheme(to theme: AppTheme) {
 UIApplication.shared.windows.forEach { window in
 window.overrideUserInterfaceStyle = UIUserInterfaceStyle(rawValue: theme.rawValue)!
 }
 currentTheme = theme.rawValue
 }
 }
 
 
 
 @Main'in olduğu kısma
 
 private func changeAppTheme() {
         UIApplication.shared.windows.forEach { window in
             window.overrideUserInterfaceStyle = UIUserInterfaceStyle(rawValue: Utils.currentTheme)!
         }
     }
 
 
 Kullanımı ------
 
 ContentView().onAppear ...
 
 .onAppear {
 
 changeAppTheme()
 
 }
 
 
 changeTheme(to ..... bunu da user'a koyu/açık tema seçtirilen yere eklenecek
 
 
 */

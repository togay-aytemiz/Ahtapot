//
//  Extensions.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 23.04.2021.
//

import Foundation
import SwiftUI

extension Text {
    func StatLabelStyle() -> Text {
        self
            .foregroundColor(Color.white)
            .font(.system(size: 10, weight: .bold, design: .rounded))
    }
    
    func ScoreNumberStyle() -> Text {
        self
            .foregroundColor(Color.white)
            .font(.system(.title2, design: .rounded))
            .fontWeight(.heavy)
            
    }
}


extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}


extension String {
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
    }
}


extension UIApplication {
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
}



//
//extension String {
//    
//    func randomPlaceholderGenerator () -> String {
//        
//        let pht = ["BBBB","BBBB","CCCC"]
//        let randomText = pht.randomElement()!
//        
//        
//        return randomText
//    }
//}



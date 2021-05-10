//
//  HideKeyboardExtension.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 10.04.2021.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

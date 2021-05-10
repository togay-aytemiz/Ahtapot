//
//  ContentView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 18.04.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
   
    //@AppStorage("isDarkMode") private var isDarkMode: Bool = false

    
    init() {
        
        UITextView.appearance().backgroundColor = .clear
        UIApplication.shared.applicationIconBadgeNumber = 0
        //UIApplication.shared.statusBarStyle = isDarkMode ? .lightContent : .darkContent
        
    }

    var body: some View {
 
        MainTaskView()
        
        // ----------- deneme view'lar -----------
        
        //DateSelectionViewForMainPage()
        

        
    }


}




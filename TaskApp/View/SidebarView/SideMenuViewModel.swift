//
//  SideMenuViewModel.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 10.05.2021.
//

import Foundation


enum SideMenuViewModel: Int, CaseIterable {
    case homepage
    case settings
    
    
    var title: String {
        switch self {
        case .homepage: return "home"
        case .settings: return "settings"
        }
    }
    
    var imageName: String {
        switch self{
        case .homepage: return "house"
        case .settings: return "gearshape"
        }
    }
}

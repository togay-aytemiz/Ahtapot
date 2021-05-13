//
//  OnboardingData.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 20.04.2021.
//

import Foundation


struct Page {
    let image: String
    let title: String
    let text: String
}


let onboardingViewTabs = [
    
    // TAB 1
    Page(
        image: "1",
        title: "onboardingTitle1".localized(),
        text: "onboardingDescription1".localized()),
    
    // TAB 2
    Page(
        image: "2",
        title: "onboardingTitle2".localized(),
        text: "onboardingDescription2".localized()),
    
    // TAB 3
    Page(
        image: "3",
        title: "onboardingTitle3".localized(),
        text: "onboardingDescription3".localized()),
    
    // TAB 4
    Page(
        image: "4",
        title: "onboardingTitle4".localized(),
        text: "onboardingDescription4".localized())
]

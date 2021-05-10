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
        title: "Sonsuza Kadar Ücretsiz",
        text: "Evet yanlış okumadın.\nÜcretsiz, reklamsız, şartsız. Tamamen koşulsuz yeni nesil görev yönetim uygulaması 🥳"),
    
    // TAB 2
    Page(
        image: "2",
        title: "Unutmaya Son!",
        text: "'Yaa aklımda bi şey vardı ama neydi' kelimeleri tanıdık geldi mi. Bunları unutabilirsin 🙈"),
    
    // TAB 3
    Page(
        image: "3",
        title: "İster yapılacaklar,\nister alışveriş listesi",
        text: "İhtiyaçların neyse buna cevap veren bir uygulama. Esnek, hızlı, göz alıcı ve kullanımı kolay 🤩"),
    
    // TAB 4
    Page(
        image: "4",
        title: "Hayatına Daha Fazla Zaman Ayır",
        text: "İşlerini planla, uygulamaya giriş yap ve gerisini unut. Artık daha planlı olacaksın 😎")
]

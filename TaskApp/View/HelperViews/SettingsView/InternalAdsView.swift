//
//  InternalAdsView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 24.04.2021.
//

import SwiftUI

struct InternalAdsView: View {
    // MARK: PROPERTIES
    
    
    let haptics = UIImpactFeedbackGenerator()
    @AppStorage("isInternalAdsShow") private var isInternalAdsShow: Bool?

    
    
    // MARK: BODY
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            

            // BACKGROUND & CONTENT
            Group{
                RoundedRectangle(cornerRadius: 12)
                    .fill(Utils.AppThemeBackgroundColor)
                    .animation(.spring())


                Image("adsBackground")
                    .resizable()
                    .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                    .animation(.spring())

            }
            .animation(.spring())
            
            // ILLUSTRATION
            VStack{
                Spacer()
                Image("iconSmall")
                    .resizable()
                    // because its asset image
                    .renderingMode(.template)
                    .scaledToFit()
                    .opacity(0.2)
                    .foregroundColor(.white)
                    
                
                Spacer()
            }
            .padding()
            .frame(width: 100)
            
            VStack(alignment: .leading){
                SettingsLabelView(labelText: "whyShouldYouUseAhtapot".localized(), labelImage: "info.circle.fill", color: .white, gradientImage: false).padding(.bottom, 12)
                
                HStack {
                    VStack(alignment: .leading, spacing: 6){
                        AppFeatures(text: "whyShouldYouUseAhtapot_Claim1".localized())
                        AppFeatures(text: "whyShouldYouUseAhtapot_Claim2".localized())
                        AppFeatures(text: "whyShouldYouUseAhtapot_Claim3".localized())
                        AppFeatures(text: "whyShouldYouUseAhtapot_Claim4".localized())
                    }
                    
                }
                
                
                Spacer()
                
            }
            .padding()
            .padding(.bottom)
            
            
            
            // GÖSTER - GÖSTERME BUTTONU
            Group{
                Button(action: {
                    haptics.impactOccurred()
                    isInternalAdsShow = false
                }, label: {
                    HStack {
                        Image(systemName: "eye.slash.fill")
                            .font(.caption)
                        Text("dontShow_WSYUA".localized())
                            .font(.system(.footnote, design: .rounded))
                            .multilineTextAlignment(.trailing)
                            
                            
                    }
                    .padding(.vertical, 6)
                    .padding(.horizontal, 10)
                    .background(Color("ColorTransparentBlack"))
                    .cornerRadius(8)
                    .foregroundColor(Color.white)
                    .padding(8)
                })
            }
              
        }
        .frame(maxWidth: 640, idealHeight: 220, maxHeight: 220)
        .animation(.spring())
        
    }
}


// MARK: PREVIEW
struct InternalAdsView_Previews: PreviewProvider {
    static var previews: some View {
        InternalAdsView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
            .previewDisplayName("iPhone 12 Pro Max")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}


struct AppFeatures: View {
    
    //var image: String = "chevron.right"
    var text: String = "Sınırsız ve reklamsız"
    
    var body: some View {
        HStack{
            
            
            Image(systemName: "checkmark.circle.fill")
            Text(text)
                .font(.system(.body, design: .rounded))
                
            
            
        }
        .foregroundColor(.white)
        .scaledToFit()
        .minimumScaleFactor(0.5)
    }
}

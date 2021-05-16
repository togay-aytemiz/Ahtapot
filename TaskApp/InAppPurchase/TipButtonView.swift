//
//  TipButtonView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 15.05.2021.
//

import SwiftUI

struct TipButtonView: View {
    // MARK: PROPERTIES
    
    @State private var tipActionDetailView = false
    let haptics = UIImpactFeedbackGenerator()
    @AppStorage("appColor1") private var AppColor1: String = "Color1A"
    @AppStorage("appColor2") private var AppColor2: String = "Color1B"
    @Binding var selectedTab: String

    
    
    
    // MARK: BODY
    var body: some View {
        
        VStack {
            Button(action: {
                tipActionDetailView.toggle()
                haptics.impactOccurred()
            }, label: {
                
                // BUTTON CUSTOMIZATION START
                // -------------------------

                
                
                
                HStack {
                    Image("gift")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 64, height: 64)
                        .padding(.trailing)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5 )
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("giftButtonHeader".localized())
                            .font(.system(.headline, design: .rounded))
                            .fontWeight(.semibold)
                            .foregroundColor(Color.white)
                            .lineLimit(2)
                            .minimumScaleFactor(0.1)
                        
                        
                        Text("giftButtonDescription".localized())
                            .font(.system(.subheadline, design: .rounded))
                            .fontWeight(.regular)
                            .foregroundColor(Color.white.opacity(0.8))
                            .lineLimit(3)
                            .minimumScaleFactor(0.1)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                        .accentColor(Color(.systemGray2))
                        .foregroundColor(.white)
                        
                }
                .padding()
                .background(LinearGradient(gradient: Gradient(colors: [Color(AppColor1), Color(AppColor2)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .cornerRadius(12)
                
                
                
                
                
                
                // -------------------------
                // BUTTON CUSTOMIZATION END
                
            })
        }
        .sheet(isPresented: $tipActionDetailView, content: {
            TipActionDetailView(selectedTab: $selectedTab)
    })
    }
}


// MARK: PREVIEW
struct TipButtonView_Previews: PreviewProvider {
    static var previews: some View {
        TipButtonView(selectedTab: .constant("settings"))
            .previewLayout(.sizeThatFits)
    }
}

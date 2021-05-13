//
//  OnboardingView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 20.04.2021.
//

import SwiftUI

struct OnboardingView: View {
    
    //@AppStorage("isOnboarding") var isOnboarding: Bool?
    //@AppStorage("isFirstTime") var isFirstTime: Bool = true

    @State private var selection = 0
    
    @Environment(\.managedObjectContext) var context
    @StateObject var homeData = HomeViewModel()

    
    var body: some View {

        
        ZStack(alignment: .top){
            
            
            
            // ONBOARDING TABS
        
            PageTabView(selection: $selection)
                .padding(.bottom, 40)

            VStack{
                Spacer()
                ButtonView(selection: $selection)
                    .padding(.bottom)
                    .padding(.bottom)
            }
            
            // LOGO
            VStack {
                Image("iconColorized")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50)

                Text("Ahtapot")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.heavy)
                    .foregroundColor(Color("Color1"))
            }
            
            
//            // SKIP BUTTON
//            HStack{
//                Spacer()
//                Button(action: {
//                    isOnboarding = false
//                }, label: {
//                    HStack(spacing: nil) {
//                        Text("Geç")
//                            .font(.system(.headline, design: .rounded))
//                            .fontWeight(.bold)
//                        
//                        Image(systemName: "arrow.right")
//                            .font(.title3)
//                            
//                    }
//                })
//                .foregroundColor(Color("Color1"))
//                .padding()
//                .opacity(0.7)
//                
//            }
//            .foregroundColor(.white)
            
        } // ZSTACK
        .animation(.default)
        .transition(.move(edge: .bottom))
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
            
    }
}

//
//  WelcomeMessageView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 3.05.2021.
//

import SwiftUI

struct WelcomeMessageView: View {
    // MARK: PROPERTIES
    
    
    @Binding var isFirstTimeUsingApp: Bool
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    @State private var animatingSymbol: Bool = false
    @State private var animatingModal: Bool = false
    
    let haptics = UIImpactFeedbackGenerator()
    
    
    // MARK: BODY
    var body: some View {
        ZStack {
            
            Color("ColorTransparentBlack").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)

            
            VStack(alignment: .center){
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    VStack(spacing: 5) {
                        Image("iconColorized")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                        Text("beforeStart".localized())
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.heavy)
                            .foregroundColor(Utils.isDarkMode ? Color.white : Color.black)
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    Spacer()
                }
                .padding(.vertical)
                Spacer()
                
                
                
                
                Text("firstUserMessageDescription1".localized())
                    .font(.system(.body, design: .rounded))
                    .fontWeight(.regular)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .lineLimit(4)
                    .minimumScaleFactor(0.7)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding()
                
                Text("firstUserMessageDescription1".localized())
                    .font(.system(.footnote, design: .rounded))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                    .minimumScaleFactor(0.7)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding()
                
                

                
                Spacer()
                
                
                
                Button(action: {
                    isFirstTimeUsingApp = false
                    animatingModal = false
                    haptics.impactOccurred()
                    
                }, label: {
                    Label(
                        title: { Text("firstUserLetsGo".localized())
                            .font(.system(.headline, design: .rounded))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .lineLimit(1)
                            .minimumScaleFactor(0.1)
                        },
                        icon: { Image(systemName: "aarrow.right.circle.fill")
                            .font(.system(.headline, design: .rounded))
                            .foregroundColor(.white)
                            
                        })
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Utils.AppThemeBackgroundColor)
                        .cornerRadius(8)
                        .shadow(color: Color(Utils.AppColor1).opacity(0.3), radius: 5, x: 0, y: 5 )
                })
                .padding()
                .padding(.horizontal)
                
                Spacer()
                Spacer()
            }
//            .frame(width: UIScreen.main.bounds.width-30, alignment: .center)
//            .padding(.bottom)
            .frame(minWidth: 280, idealWidth: 280, maxWidth: 320, minHeight: 260, idealHeight: 280, maxHeight: 480, alignment: .center)
            .background(colorScheme == .dark ? Color.black : Color.white)
            .cornerRadius(20)
            //.modifier(ShadowModifier())
            .opacity($animatingModal.wrappedValue ? 1 : 0)
            .offset(y: $animatingModal.wrappedValue ? 0 : -100)
            .animation(Animation.spring(response: 0.6, dampingFraction: 1.0, blendDuration: 1.0))
            .padding(.horizontal)
            .onAppear(perform: {
                animatingModal = true
            })
        }
    }
}

// MARK: PREVIEW
struct WelcomeMessageView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeMessageView(isFirstTimeUsingApp: .constant(true))
            .preferredColorScheme(.light)
    }
}

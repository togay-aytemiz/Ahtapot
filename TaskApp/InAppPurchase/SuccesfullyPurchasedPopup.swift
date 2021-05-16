//
//  SuccesfullyPurchasedPopup.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 16.05.2021.
//

import SwiftUI

struct SuccesfullyPurchasedPopup: View {

    // MARK: PROPERTIES
    
    //@AppStorage("isDarkMode") private var isDarkMode: Bool = false

    @EnvironmentObject private var store: Store

    @State private var animatingSymbol: Bool = false
    @State private var animatingModal: Bool = false
    @Binding var showingModal: Bool
    @Binding var selectedTab: String
    
    var popupText: String = "succesfullyPurchasedPopupContext".localized()
    
    var action: () -> Void

    let haptics = UIImpactFeedbackGenerator()

    // MARK: BODY
    var body: some View {
        ZStack {
            
            Color("ColorTransparentBlack").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            // MODAL
            
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0, content: {
                
                //başlık
                Text("succesfullyPurchasedPopupHeader".localized())
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.heavy)
                    .padding()
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(Color.white)
                
                Spacer()
                
                // message
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 16, content: {
                    Text("🥳 🤩")
                        .font(.largeTitle)

                    
                    Text(popupText)
                        .font(.system(.body, design: .rounded))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.gray)
                        .lineLimit(3)
                        .minimumScaleFactor(0.1)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding()
                    
                    HStack {
                        
                        Button(action: {
                            store.successfullyPurchased = false
                            animatingModal = false
                            haptics.impactOccurred()
                           
                        }, label: {
                            Text("succesfullyPurchasedPopupAct_Again".localized())
                                .font(.system(.body, design: .rounded))
                                .fontWeight(.semibold)
                                .foregroundColor(Color(Utils.AppColor1))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .frame(minWidth: 128)
                                
                        })
                        
                        
                        
                        Button(action: {
                            store.successfullyPurchased = false
                            animatingModal = false
                            haptics.impactOccurred()
                            action()
                            selectedTab = "today"
                           
                        }, label: {
                            Text("succesfullyPurchasedPopupAct_HomePage".localized())
                                .font(.system(.body, design: .rounded))
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .frame(minWidth: 128)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        //.strokeBorder(lineWidth: 1.75)
                                        //.foregroundColor(Color.white)
                                        .fill(Utils.AppThemeBackgroundColor)
                                )
                        })
                        
                    } //HSTACK
                    .padding(.top, 6)
                })
                
                Spacer()
                
                
            })
            .frame(minWidth: 280, idealWidth: 280, maxWidth: 320, minHeight: 260, idealHeight: 280, maxHeight: 320, alignment: .center)
            .background(Utils.isDarkMode ? Color.black : Color.white)
            .cornerRadius(20)
            //.modifier(ShadowModifier())
            .opacity($animatingModal.wrappedValue ? 1 : 0)
            .offset(y: $animatingModal.wrappedValue ? 0 : -100)
            .animation(Animation.spring(response: 0.6, dampingFraction: 1.0, blendDuration: 1.0))
            .onAppear(perform: {
                animatingModal = true
            })
            
        }
    }
}
struct SuccesfullyPurchasedPopup_Previews: PreviewProvider {
    static var previews: some View {
        SuccesfullyPurchasedPopup(showingModal: .constant(false), selectedTab: .constant("settings")) {
            //
        }
    }
}

//
//  CustomPopup.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 19.04.2021.
//

import SwiftUI

struct CustomPopup: View {
    // MARK: PROPERTIES
    
    //@AppStorage("isDarkMode") private var isDarkMode: Bool = false

    @State private var animatingSymbol: Bool = false
    @State private var animatingModal: Bool = false
    @Binding var showingModal: Bool
    
    var popupText: String = "Tamamlanan tüm görevleri silmek istediğinden emin misin? Bu işlem geri alınamaz"
    
    var action: () -> Void

    let haptics = UIImpactFeedbackGenerator()

    // MARK: BODY
    var body: some View {
        ZStack {
            
            Color("ColorTransparentBlack").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            // MODAL
            
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0, content: {
                
                //başlık
                Text("Siliniyor")
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.heavy)
                    .padding()
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity)
                    .background(Color.red)
                    .foregroundColor(Color.white)
                
                Spacer()
                
                // message
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 16, content: {
                    Image(systemName: "trash.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 72)
                        .foregroundColor(.red)

                    
                    Text(popupText)
                        .font(.system(.body, design: .rounded))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.gray)
                        .lineLimit(2)
                        .minimumScaleFactor(0.7)
                        .fixedSize(horizontal: false, vertical: true)
                        .layoutPriority(0)
                        .padding()
                    
                    HStack {
                        
                        Button(action: {
                            showingModal = false
                            animatingModal = false
                            haptics.impactOccurred()

                            //action()
                           
                        }, label: {
                            Text("VAZGEÇTİM")
                                .font(.system(.body, design: .rounded))
                                .fontWeight(.semibold)
                                .foregroundColor(Color.red)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .frame(minWidth: 128)
                                
                        })
                        
                        
                        
                        Button(action: {
                            showingModal = false
                            animatingModal = false
                            haptics.impactOccurred()
                            action()
                           
                        }, label: {
                            Text("EMİNİM, SİL")
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
                                        .fill(Color.red)
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


// MARK: PREVIEW
struct CustomPopup_Previews: PreviewProvider {
    static var previews: some View {
        CustomPopup(showingModal: .constant(true), action: {
            //
        })
        .padding()
    }
}

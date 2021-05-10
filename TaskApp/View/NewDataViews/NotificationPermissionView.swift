//
//  NotificationPermissionView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 27.04.2021.
//

import SwiftUI

struct NotificationPermissionView: View {
    // MARK: PROPERTIES
    
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("isNotificationPermissionReceived") private var isNotificationPermissionReceived: Bool = false
  
    
    @Binding var isRemindMeActive: Bool
    
    let haptics = UIImpactFeedbackGenerator()

    
    // MARK: BODY
    var body: some View {
        
        
        ZStack {
            
            Utils.isDarkMode ? Color.black.edgesIgnoringSafeArea(.all) : Color.white.edgesIgnoringSafeArea(.all)
            
            VStack{
                
               
                HStack{
                    
                    Spacer()
                    Text("Şimdilik Geç")
                        .font(.subheadline)
                        .foregroundColor(Utils.isDarkMode ? .white : .secondary)
                }
                .padding()
                .padding(.horizontal)
                .padding(.top)
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                    haptics.impactOccurred()
                }
                
                Spacer()
                
                // IMAGES
                Group {
                    
                    
                    Image("bell")
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(0.7)
                        .frame(maxWidth: 200)
                        .opacity(Utils.isDarkMode ? 0.5 : 1)
                    
                    
                    Image("notifPlaceholder")
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(0.7)
                        .frame(maxWidth: 600)
                        .opacity(Utils.isDarkMode ? 0.5 : 1)
                }
                
                Spacer()
                
                
                // TEXT
                Group {
                    
                    
                    VStack(alignment: .center, spacing: 10){
                        Text("Bildirimleri Aç\nHiç Bir Şeyi Kaçırma")
                            .font(.system(.title2, design: .rounded))
                            .fontWeight(.heavy)
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .fixedSize(horizontal: false, vertical: true)
                            .minimumScaleFactor(0.5)
                            .foregroundColor(Utils.isDarkMode ? .white : .black)
                            
                        
                        
                        Text("Bildirimlere izin vererek, planlamasını yaptığın etkinliklerin sana hatırlatılmasını sağlayabilirsin.")
                            .font(.system(.headline, design: .rounded))
                            .foregroundColor(Utils.isDarkMode ? .white.opacity(0.7) : .secondary)

                            .fontWeight(.light)
                            .multilineTextAlignment(.center)
                            .lineLimit(3)
                            .fixedSize(horizontal: false, vertical: true)
                            .minimumScaleFactor(0.5)
                            
                            
                        
                    }
                    
                    
                    Text("Planladığın görevler dışında hiç bir bildirim göndermeyeğimize söz veriyoruz 😇")
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundColor(Color("Color2B"))
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .padding(.top, -15)
                        .lineLimit(3)
                        .fixedSize(horizontal: false, vertical: true)
                        
                      
                }
                
                .padding()
                .frame(maxWidth: 400)
                
                Spacer()
                
                // MARK: BUTTON
                Group{
                    Button(action: {
                        // add task action
                        haptics.impactOccurred()
                        NotificationManager.istance.requestAuthorization()
                        isNotificationPermissionReceived = true
                        presentationMode.wrappedValue.dismiss()
                        isRemindMeActive = true
                    }, label: {
                        Label(
                            title: { Text("Bildirimlere İzin Ver")
                                .font(.system(.headline, design: .rounded))
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                            },
                            icon: { Image(systemName: "bell.badge.fill")
                                .font(.system(.headline, design: .rounded))
                                .foregroundColor(.white)
                                
                            })
                            .padding(.vertical)
                            .frame(maxWidth: 400)
                            .background(Utils.AppThemeBackgroundColor)
                            .cornerRadius(8)
                            .shadow(color: Color(Utils.AppColor1).opacity(0.3), radius: 5, x: 0, y: 5 )
                    })
                    .padding(.bottom)
                    .padding(.horizontal)
                    
                    
                    
                }
               
                
                Spacer()
                
                
                
                    
            }
            .frame(width: UIScreen.main.bounds.width-20, alignment: .center)
        }
    }
    
}


// MARK: PREVIEW
struct NotificationPermissionView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationPermissionView(isRemindMeActive: .constant(true))
            
            
            
    }
}

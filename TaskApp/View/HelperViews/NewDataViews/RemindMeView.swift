//
//  RemindMeView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 26.04.2021.
//

import SwiftUI

struct RemindMeView: View {
    // MARK: PROPERTIES
    
    @ObservedObject var homeData : HomeViewModel
    @AppStorage("isNotificationPermissionReceived") private var isNotificationPermissionReceived: Bool = false
    @Binding var isUserWantsNotification : Bool
    @State private var isRemindMeActive: Bool = true

    
    let haptics = UIImpactFeedbackGenerator()

    var someStatus: Bool {
        if homeData.isRemindMe == true || isUserWantsNotification == true {
            return true
        } else {
            return false
        }
    }
    
    
    
    
    // MARK: BODY
    var body: some View {
        HStack{
            // Illustration
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color(Utils.AppColor1)).opacity(0.5)
                    .shadow(color: Color(Utils.AppColor1).opacity(0.7), radius: 8, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 6.0)

                Image(systemName: someStatus ? "bell" : "bell.slash")
                    .foregroundColor(Color.white)
                
            }
            .frame(width: 36, height: 36, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

            HStack {
                VStack(alignment: .leading){
                    Text(someStatus ? "remindMeOpen".localized() : "remindMeClosed".localized())
                        .font(.system(.headline, design: .rounded))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Utils.isDarkMode ? Color.white : Color.black)
                    
                    if someStatus {
                        HStack {
                            Text("\(homeData.date, formatter: miniDateAndTimeFormat)")
                                .font(.system(.subheadline, design: .rounded))
                                .fontWeight(.light)
                                .foregroundColor(Utils.isDarkMode ? Color.white : Color.black)
                            
                            Text("-")
                                .font(.system(.subheadline, design: .rounded))
                                .fontWeight(.light)
                                .foregroundColor(Utils.isDarkMode ? Color.white : Color.black)
                            
                            Text("\(homeData.date, formatter: shortDateFormat)")
                                .font(.system(.subheadline, design: .rounded))
                                .fontWeight(.light)
                                .foregroundColor(Utils.isDarkMode ? Color.white : Color.black)
                        }
                        .lineLimit(1)
                        .minimumScaleFactor(0.1)
                        
                        
                        
                    } else {
                        Text("howToOpenReminder".localized())
                            .font(.system(.footnote, design: .rounded))
                            .fontWeight(.light)
                            .foregroundColor(Utils.isDarkMode ? Color.white : Color.black)
                            .lineLimit(1)
                            .minimumScaleFactor(0.1)
                    }
                    
                    
                    
                }
                .padding(.leading, 6)
                
                Spacer()
                
                
         
                
                
                if !isNotificationPermissionReceived {
                    Button(action: {
                        homeData.isNotifResponseShow = true
                        haptics.impactOccurred()
                    }, label: {
                        Text("firstTimeOpenReminder".localized().uppercased())
                            .font(.system(.headline, design: .rounded))
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 14)
                            .background(Utils.AppThemeBackgroundColor)
                            .cornerRadius(6)
                            .foregroundColor(.white)
                            .shadow(color: Color(.black).opacity(0.3), radius: 8, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 6.0)

                    })
                } else {
                    Toggle(isOn: homeData.updateItem != nil ? $homeData.isRemindMe : $isUserWantsNotification, label: {
                        /*@START_MENU_TOKEN@*/Text("Label")/*@END_MENU_TOKEN@*/
                    })
                    .labelsHidden()
                    .opacity(isRemindMeActive ? 1 : 0.8)
                    .toggleStyle(SwitchToggleStyle(tint: Color(Utils.AppColor1)))
                    .shadow(color: isRemindMeActive ? Color(Utils.AppColor1).opacity(0.4) : Color(Utils.AppColor1).opacity(0.0) , radius: 8, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 6.0)
                }
                
                
                
//                if !isNotificationPermissionReceived {
//                    Button(action: {
//                        homeData.isNotifResponseShow = true
//
//                    }, label: {
//                        Text("AÇ")
//                    })
//                } else {
//                    Toggle(isOn: $homeData.isRemindMe, label: {
//                        /*@START_MENU_TOKEN@*/Text("Label")/*@END_MENU_TOKEN@*/
//                    })
//                    .labelsHidden()
//                    .opacity(isRemindMeActive ? 1 : 0.8)
//                    .toggleStyle(SwitchToggleStyle(tint: Color(AppColor1)))
//                    .shadow(color: isRemindMeActive ? Color(AppColor1).opacity(0.4) : Color(AppColor1).opacity(0.0) , radius: 8, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 6.0)
//                }
                
                


                
            }
            
            Spacer()
            
            
            
                
            
        }
        .padding()
        .background(Color(Utils.AppColor1).opacity(0.15))
        .cornerRadius(8)
        
    }
    
    
    
}

// MARK: PREVIEW
struct RemindMeView_Previews: PreviewProvider {
    static var previews: some View {
        RemindMeView(homeData: HomeViewModel(), isUserWantsNotification: .constant(true))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

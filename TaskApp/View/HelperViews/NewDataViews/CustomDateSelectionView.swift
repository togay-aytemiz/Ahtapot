//
//  CustomDateSelectionView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 26.04.2021.
//

import SwiftUI

struct CustomDateSelectionView: View {
    // MARK: PROPERTIES

    @ObservedObject var homeData : HomeViewModel
    @Environment(\.managedObjectContext) var context   

    // SOME STATES
    @State private var isCustomDatePickerIsOn : Bool = false
    @State private var isHideKeyboard: Bool = false
    @State private var hiddenPlaceholder = ""
   
    // OTHERS
    let haptics = UIImpactFeedbackGenerator()
    
    
    
    // MARK: BODY
    var body: some View {
        
        
        // MARK: REMINDER BUTTONS
        Group{
            VStack(alignment: .leading){

                VStack(alignment: .leading){
                    
                    if homeData.updateItem == nil {
                                                
                        ScrollView(.horizontal, showsIndicators: false, content: {
                            
                            HStack(spacing:10){
                                Text("when".localized())
                                    .font(.system(.headline, design: .rounded))
                                    .fontWeight(.semibold)
                                    .foregroundColor(!Utils.isDarkMode ? .black : .white)
                                
                                
                                
                                DateButton(title: "1HourLater".localized(), homeData: homeData)
                                DateButton(title: "tomorrow".localized(), homeData: homeData)
                                DateButton(title: "nextDay".localized(), homeData: homeData)
                                DateButton(title: "1WeekLater".localized(), homeData: homeData)
                                DateButton(title: "15DaysLater".localized(), homeData: homeData)
                                Spacer()
                            }
                            
                        })
                        .padding(.leading)
                        .padding(.top, -5)
                        .padding(.bottom, 1)
                        
                    }
                    
                    
                    // MARK: DATE PICKER
                    
                    
                    HStack{
                        
//                        Text("🗓")
                        Image(systemName: "calendar.badge.clock")
                            .foregroundColor(Color(Utils.AppColor1))
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                        
                        DatePicker("",
                                   selection: $homeData.date,
                                   //in: Date()...,
                                   displayedComponents: [.date, .hourAndMinute])
                            .labelsHidden()
                            //.environment(\.locale, Locale.init(identifier: "tr"))
                            .animation(.easeInOut)
                            .colorScheme(Utils.isDarkMode ? .dark : .light)
                            .accentColor(Color(Utils.AppColor1))
                            
                            
                        
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    .animation(.default)
                    
                    
                    
                }
            }
        }
    }
}

struct CustomDateSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        CustomDateSelectionView(homeData: HomeViewModel())
            
    }
}




//                            HStack(spacing: -1) {
//
//
//                                Text(homeData.date, formatter: ShortDateAndTimeFormatter)
//                                    .font(.system(.headline, design: .rounded))
//                                    .fontWeight(.light)
//                                    .environment(\.locale, Locale.init(identifier: "tr"))
//                                    .foregroundColor(Color(AppColor1))
//                                    .padding(.vertical, 6)
//                                    .padding(.horizontal, 10)
//
//
//                                Image(systemName: isCustomDatePickerIsOn ? "chevron.up" : "chevron.down")
//                                    .padding(.trailing)
//                                    .font(.system(.headline, design: .rounded))
//                                    .foregroundColor(Color(AppColor1))
//
//                            }
//
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 6)
//                                    .stroke(Color(AppColor1), lineWidth: 1)
//                            )
//                            .onTapGesture(perform: {
//                                isCustomDatePickerIsOn.toggle()
//                                haptics.impactOccurred()
//                                hideKeyboard()
//                            })



//// MARK: GRAPHICAL DATE PICKER
//if isCustomDatePickerIsOn {
//    // Date picker...
//    VStack(spacing: 0) {
//
//
//
//        DatePicker("", selection: $homeData.date, in: Date()...,  displayedComponents: [.date, .hourAndMinute])
//                .labelsHidden()
//                .environment(\.locale, Locale.init(identifier: "tr"))
//                .datePickerStyle(GraphicalDatePickerStyle())
//                .padding(.horizontal, 50)
//                .animation(.default)
//                .colorScheme(isDarkMode ? .dark : .light)
//                .accentColor(Color(AppColor1))
//                //.scaleEffect(0.8)
//
//
//
//
//        HStack {
//
//            Text("Seçimi Tamamla")
//                .font(.system(.headline, design: .rounded))
//                .fontWeight(.light)
//
//            Image(systemName: "chevron.up")
//
//        }
//        .foregroundColor(.white)
//        .padding(.vertical, 6)
//        .padding(.horizontal, 14)
//        .background(LinearGradient(gradient: Gradient(colors: [Color(AppColor1), Color(AppColor2)]), startPoint: .topLeading, endPoint: .bottomTrailing))
//        .cornerRadius(6)
//        .shadow(color: Color(.black).opacity(0.3), radius: 8, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 6.0)
//        .onTapGesture {
//            isCustomDatePickerIsOn = false
//            haptics.impactOccurred()
//        }
//        .padding(.top, -10)
//
//
//
//
//        Divider()
//            .padding()
//    }
//}

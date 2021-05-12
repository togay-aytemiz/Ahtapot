//
//  NewDataView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 18.04.2021.
//

import SwiftUI
import UIKit

struct NewDataView: View {
    // MARK: PROPERTIES
    
    @ObservedObject var homeData : HomeViewModel
    @Environment(\.managedObjectContext) var context
    @AppStorage("isNotificationPermissionReceived") private var isNotificationPermissionReceived: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isCustomDatePickerIsOn : Bool = false
    @State private var isHideKeyboard: Bool = false
    @State private var hiddenPlaceholder = ""
    @State private var isUserWantsNotification = false
    
    let haptics = UIImpactFeedbackGenerator()
    
    var completion: Color {
        if Utils.isDarkMode {
            return Color.white.opacity(0.5)
        } else {
            return Color.gray.opacity(0.3)
        }
    }
    

    
    // MARK: BODY
    var body: some View {
        
        
        // MARK: MAIN VSTACK
        ZStack(alignment: .bottom){
            
            Utils.isDarkMode ? Color.black.edgesIgnoringSafeArea(.all) : Color.white.edgesIgnoringSafeArea(.all)
            
        VStack{
            
                
            // MARK: HEADER
            Group{
                HStack{
                    VStack(alignment: .leading) {
                        Text(homeData.updateItem == nil ? "addTask".localized() : "editTask".localized())
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                        if homeData.completion {
                            Text("completedTask".localized())
                                .font(.system(.subheadline, design: .rounded))
                                .fontWeight(.regular)
                                .foregroundColor(.white)
                        }

                    }


                    Spacer()

                    Button(action: {
                        homeData.isNewData.toggle()
                        homeData.content = ""
                        homeData.updateItem = nil
                        homeData.completion = false
                        haptics.impactOccurred()

                    }, label: {
                        HStack(spacing: 4) {
                            Image(systemName: "xmark.circle.fill")
                            Text("cancel".localized())
                        }
                    })
                    .accentColor(Color.white)

                }
                .padding()
                .background(homeData.completion ? Utils.backgroundGradientBlack : Utils.AppThemeBackgroundColor )
                .onTapGesture {
                    hideKeyboard()
                }
            }

            
            
            // MARK: DATE SELECTION
            if homeData.completion == false {
            CustomDateSelectionView(homeData: homeData)
                .padding(.top)
            }
                        


            // MARK: CONTENT
            ZStack(alignment: .topLeading) {
                
                if homeData.updateItem == nil {
                    if homeData.content.isEmpty {
                        Text(homeData.randomTextGenerator())
                            .font(.system(.subheadline, design: .rounded))
                            .foregroundColor(Utils.isDarkMode ? Color.white.opacity(0.7) : Color.gray.opacity(0.7))
                            .padding(.leading, 8)
                    }
                }
                

                
                VStack(alignment: .leading, spacing: 2){

                 
                    if homeData.updateItem != nil {
                        HStack {
                            Image(systemName: "circle")
                                .font(.system(size: 24, weight: .semibold, design: .rounded))
                                .opacity(0)
                            
                            Text("tapTextToEdit".localized())
                                .font(.system(.footnote, design: .rounded))
                                .foregroundColor(!Utils.isDarkMode ? .black.opacity(0.8) : .white.opacity(0.8))
                        }
                    }
                    
                    

                    
                    HStack(alignment: .top) {
                        if homeData.updateItem != nil {
                            Image(systemName: homeData.completion ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(homeData.completion ? completion : Color(Utils.AppColor1))
                                .font(.system(size: 24, weight: .semibold, design: .rounded))
                                .onTapGesture {
                                    homeData.isRemindMe = false
                                    homeData.completion.toggle()
                                    NotificationManager.istance.cancelNotification(idArray: [homeData.content])
                                    homeData.writeData(context: context)
                                    haptics.impactOccurred()
                                    
                                }
                                .offset(y:6)
                        }
                        
                        
                        TextEditor(text: $homeData.content)
                        //TextField("", text: $homeData.content)
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                            .disableAutocorrection(true)
                            .autocapitalization(.sentences)
                            .foregroundColor(!Utils.isDarkMode ? .black : .white)
                            //.frame(maxHeight: 150)
                            .accentColor(Color(Utils.AppColor1))
                            .colorScheme(Utils.isDarkMode ? .dark : .light)
                    }
                
                }
                
            }
            .padding()
            .onTapGesture {
                hideKeyboard()
            }
            
            
            
            Spacer()
            
            
            
            // MARK: BANA HATIRLAT
            if !homeData.content.isEmpty  {
                if homeData.completion == false {
                RemindMeView(homeData: homeData, isUserWantsNotification: $isUserWantsNotification)
                    .padding(.horizontal)
                    //.animation(.linear)
                    .onTapGesture {
                        hideKeyboard()
                    }
                }
            }
            
 
            // MARK: ADD & UPDATE BUTTON
            Group{
                Button(action: {
                    // add task action
                    if isUserWantsNotification == true || homeData.isRemindMe == true {
                        NotificationManager.istance.scheduleNotification(body: homeData.content,  id: homeData.content, date: homeData.date)
                        homeData.isRemindMe = true
                    } else if !isUserWantsNotification || homeData.isRemindMe == false {
                        homeData.isRemindMe = false
                        NotificationManager.istance.cancelNotification(idArray: [homeData.content])
                    }
                    homeData.writeData(context: context)
                    haptics.impactOccurred()
                    
                }, label: {
                    Label(
                        title: { Text(homeData.updateItem == nil ? "addTask".localized() : "update".localized())
                            .font(.title3)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        },
                        icon: { Image(systemName: homeData.updateItem == nil ? "plus.circle.fill" : "arrow.triangle.2.circlepath.circle.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                            
                        })
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 30)
                        .background(Utils.AppThemeBackgroundColor)
                        .cornerRadius(8)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5 )
                    
                    
                })
                .padding(.bottom)
                // disabling button when no context
                .disabled(homeData.content.isEmpty)
                .opacity(homeData.content.isEmpty ? 0.4 : 1 )
            }
           
            
        } // SCROLLVIEW
        
        .sheet(isPresented: $homeData.isNotifResponseShow, content: {
            NotificationPermissionView(isRemindMeActive: $isUserWantsNotification)
        })

            
        }
        
    }
}


struct NewDataView_Previews: PreviewProvider {
    static var previews: some View {
        NewDataView(homeData: HomeViewModel())
    }
}



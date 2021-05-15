//
//  SettingsMainView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 24.04.2021.
//

import SwiftUI
import UIKit
import MessageUI
import StoreKit

struct SettingsMainView: View {
    // MARK: PROPERTIES
    
    
    @StateObject var homeData = HomeViewModel()
    @State private var showModal: Bool = false
    @Binding var selectedTab: String
    
    
    // IN-APP MAIL İÇİN EKLENEN KISIM
    @State private var showSheet = false
    @State var result: Result<MFMailComposeResult, Error>? = nil

    
    // USER DEFAULTS SEÇENEKLERİ
    @AppStorage("isInternalAdsShow") private var isInternalAdsShow: Bool = true
    // @AppStorage("isTutorialShow") private var isTutorialShow: Bool = true
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @AppStorage("isBasicStatView") private var isBasicStatView: Bool = true
    
    
    // COLORS
    @AppStorage("appColor1") private var AppColor1: String = "Color1A"
    @AppStorage("appColor2") private var AppColor2: String = "Color1B"

    
    // Fetching Data from CoreData
    @Environment(\.managedObjectContext) var context

    // Fetch All Tasks
    @FetchRequest(entity: Task.entity(),sortDescriptors: [NSSortDescriptor(key: "date",ascending: true)], animation: .spring()) var results : FetchedResults<Task>
    
    @FetchRequest(entity: Task.entity(),sortDescriptors: [NSSortDescriptor(key: "date",ascending: true)],predicate: .ClosedTasks(),animation: .spring()) var closedTasks : FetchedResults<Task>

    
    
    // OTHER DETAILS
    let haptics = UIImpactFeedbackGenerator()
    @State private var closedTaskView : Bool = false
    
    @State private var isShowingSideMenu = false

    
    
    
    
    // MARK: BODY
    var body: some View {
        
        ZStack{
         
            if isShowingSideMenu {
                SideMenuView(isShowingSideMenu: $isShowingSideMenu, selectedTab: $selectedTab)
            }
        
        NavigationView {
            ZStack {
                VStack(spacing :0) {

                    
                    // MARK: HEADER
                    CustomNavigationBarView(showDate: false, shoppingIcon: false, customNavigationHeader: "settings".localized(), isShowingSideMenu: $isShowingSideMenu)
                        .background(isDarkMode ? Color.black : Color.white)
                    
                    
                    // MARK: CONTENT
                    ScrollView(.vertical, showsIndicators: false){
                        
                        // MARK: SECTION 1 - INTERNAL ADS
                        if isInternalAdsShow {
                            InternalAdsView()
                                .padding(.bottom, 15)
                        }

                        // MARK: SECTION 2 - TAMAMLANAN GÖREVLER
                        if closedTasks.count > 0 {
                            
                            Button(action: {
                                closedTaskView.toggle()
                                haptics.impactOccurred()
                            }, label: {
                                ImportantRowView(text1: "closedTasksHeader".localized(), text2: "\("numberOfClosedTaskBodyDescription".localized()) \(closedTasks.count)")
                                    .padding(.bottom)
                               
                            }) 
                        }
                    
                        // MARK: SECTION 3 - SOME CUSTOMIZATIONS
                        Group {
                            VStack{
                                SettingsLabelView(labelText: "settingsHeader_Visual".localized(), labelImage: "paintbrush.fill", color: Color(AppColor1), gradientImage: true)
                                
                                
                                
                                SettingsRowWithToggleView(color: Color(AppColor1), image: "moon.fill", text1: "darkMode".localized(), text2: "", toggleStatus: $isDarkMode)
                                
                                
                                
                                SettingsRowWithToggleView(color: Color(AppColor1), image: "chart.pie.fill", text1: "miniStats".localized(), text2: "miniStats_disclaimer".localized(), toggleStatus: $isBasicStatView)
                                
                                
                                Divider()
                                
                                ChangingThemeColor()
                                    .padding(.leading, 5)
                                
                                
                            }
                            .padding()
                            .background(Color(AppColor1).opacity(0.1))
                            .cornerRadius(8)
                            .padding(.bottom, 15)
                            
                        }
                        
                        
                        // MARK: SECTION 3.5 - TIP BUTTON
                        //TipButtonView()
                        
                        
                        
                        
                        // MARK: SECTION 4 - OTHER LINKS & BUTTONS
                        Group {
                            VStack{
                                
                                SettingsLabelView(labelText: "settingsHeader_Other".localized(), labelImage: "mail.stack.fill", color: Color(AppColor1), gradientImage: true)
                                
                                
                                // ARKADAŞINLA PAYLAŞ BUTTON
                                FormLinkRowView(icon: "square.and.arrow.up.fill", color: Color(AppColor1), text: "shareWithFriends".localized()) {
                                    homeData.sharePost(message: "shareWithFriends_ShareText".localized())
                                    haptics.impactOccurred()
                                }
                                

                                // UYGULAMAYI DEĞERLENDİR BUTTON
                                FormLinkRowView(icon: "star.fill", color: Color(AppColor1), text: "rateTheApp".localized()) {
                                    haptics.impactOccurred()
                                    //writeReview()
                                    rateApp()
                                }
                                                            
                                
                                // ÖZELLİK ÖNER & HATA PAYLAŞ BUTON
                                FormLinkRowView(icon: "sparkles.rectangle.stack.fill", color: Color(AppColor1), text: "findBugOrSuggestFeature".localized()) {
                                    suggestFeatures()
                                    haptics.impactOccurred()
                                }
                                
                                
                                // TRANSLATION SECTION
                                FormLinkRowView(icon: "doc.append.fill", color: Color(AppColor1), text: "translationFormRow".localized(), text2: "helpUsToTranslate".localized()) {
                                    suggestFeatures()
                                    haptics.impactOccurred()
                                }
                                
                                
                            
                            }
                            .padding()
                            .background(Color(AppColor1).opacity(0.1))
                            .cornerRadius(8)
                            .padding(.bottom, 15)
                        }
 
                        
                        
                        

                        
                        
                        
                        // MARK: SECTION 5 - DELETE ALL TASKS (OPEN & CLOSED) BUTTON
                        Group{
                            Button(action: {
                                showModal.toggle()
                                haptics.impactOccurred()
                            }, label: {
                                DeleteAllView()
                                    .padding(.bottom)
                            })
                        }
             
                        // MARK: SECTION 6 - LOGO & FOOTER
                        SettingsFooterIconView()
                        
                    }
                    .padding()
                    .navigationBarTitle("settings".localized())
                    .navigationBarHidden(true)
                    .ignoresSafeArea(.all, edges: .bottom)

                    
                    

                    
                    
                }
                // EMAIL SHEETLERİ AÇMA VE TAMAMLANAN TASKLARI AÇMAK İÇİN
                .background(EmptyView()
                                .sheet(isPresented : $closedTaskView) {ClosedTasks()}
                                .background(EmptyView()
                                                .sheet(isPresented : $showSheet) {
                                                    MailView(result: self.$result, newSubject: "findBugOrSuggestFeature_MailTitle".localized(), newMsgBody: "\("findBugOrSuggestFeature_MailBody".localized())\nv:\(UIApplication.appVersion ?? "")" )
                                                })
                )
                
                
                Rectangle()
                    .fill(Color.black).edgesIgnoringSafeArea(.all)
                    .opacity(isShowingSideMenu ? 0.1 : 0)
                    .onTapGesture {
                        withAnimation(.spring()){
                            isShowingSideMenu.toggle()
                        }
                    }

                
                
                // MARK: POPUP
                if $showModal.wrappedValue {
                    
                    
                    
                    ZStack {
                        
                        
                        CustomPopup(showingModal: $showModal, popupText: "deleteAllPopupText".localized()) {
                            haptics.impactOccurred()
                            deleteAll()
                            NotificationManager.istance.cancelAllNotification()
                            try! context.save()
                            selectedTab = "today"
                        }
                    }
                }
                

            }

            
        }
        .onAppear(){UITableView.appearance().backgroundColor = UIColor.clear}
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {UIApplication.shared.applicationIconBadgeNumber = 0}
        
        // SIDE MENU ACTIONS
        .cornerRadius(isShowingSideMenu ? 20 : 0)
        .scaleEffect(isShowingSideMenu ? 0.8 : 1)
        .offset(x: isShowingSideMenu ? (UIScreen.screenWidth / 5 * 3) : 0, y: isShowingSideMenu ? (UIScreen.screenHeight / 20) : 0)
        .shadow(color: Color.black.opacity(isShowingSideMenu ? 0.2 : 0), radius: 8, x: -5, y: 5 )
        //.disabled(isShowingSideMenu)
        
        

        }
        
        

    }
    
    
    // MARK: FUNCTIONS
    
    private func deleteAll(){

        for item in results {
            context.delete(item)
        }

        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func suggestFeatures() {
        if MFMailComposeViewController.canSendMail(){
            self.showSheet = true
        } else {
            print("error sending mail")
            // Alert : Unable to send the mail
        }
    }
    
    func writeReview(){
        let appURL = URL(string: "https://apps.apple.com/us/app/id1565858619")!
        var components = URLComponents(url: appURL, resolvingAgainstBaseURL: false)
        components?.queryItems = [URLQueryItem(name: "action", value: "write-review")]
        guard let writeReviewURL = components?.url else {return}
        UIApplication.shared.open(writeReviewURL)
    }
    
    func rateApp() {

        if let windowScene = UIApplication.shared.windows.first?.windowScene {
            SKStoreReviewController.requestReview(in: windowScene)
            
        }
        
    }
    
    
}


// MARK: PREVIEW
struct SettingsMainView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsMainView(selectedTab: .constant("settings"))
    }
}





//
//  ClosedTasks.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 24.04.2021.
//

import SwiftUI

struct ClosedTasks: View {
    // MARK: PROPERTIES
    
    @StateObject var homeData = HomeViewModel()
    @State private var showModal: Bool = false
    @Environment(\.presentationMode) var presentationMode

    // OTHER DETAILS
    let haptics = UIImpactFeedbackGenerator()
    
    // USERDEFAULTS SEÇENEKLERİ
    //@AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    
    // COLORS
    //@AppStorage("appColor1") private var AppColor1: String = "Color1A"
    //@AppStorage("appColor2") private var AppColor2: String = "Color1B"

    // Fetching Data from CoreData
    @Environment(\.managedObjectContext) var context
    
    
    // Fetch All Tasks
    @FetchRequest(entity: Task.entity(),sortDescriptors: [NSSortDescriptor(key: "date",ascending: true)], animation: .spring()) var results : FetchedResults<Task>
    
    // Fetch Closed Tasks
    
    @FetchRequest(entity: Task.entity(),sortDescriptors: [NSSortDescriptor(key: "date",ascending: false)],predicate: .ClosedTasks(),animation: .spring()) var closedTasks : FetchedResults<Task>
    
    
    // MARK: BODY
    var body: some View {
        
        
        
            ZStack {
                
                Utils.isDarkMode ? Color.black.edgesIgnoringSafeArea(.all) : Color.white.edgesIgnoringSafeArea(.all)
                
                
                VStack{
                    
                    
                    // MARK: HEADER BUTTONS
                    Group{
                        HStack {
                            // LEFT
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                                haptics.impactOccurred()
                            },label: {
                                HStack(spacing: 2) {
                                    Image(systemName: "chevron.down")
                                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                                    Text("close".localized())
                                        .font(.system(.headline, design: .rounded))
                                        .fontWeight(.semibold)
                                }
                            })
                            .foregroundColor(Utils.isDarkMode ? Color.white : Color.black)
                            
                            Spacer()
                        }
                        .padding()
                    }
                    
                    // MARK: HEADER
                    NavigationBarView(title: "closedTasksHeader".localized(), showDate: false)

                        .padding(.horizontal, 15)
                        //.foregroundColor(Utils.isDarkMode ? Color.white : Color.black)
                    
                    
                    
                    // MARK: SİL BUTTON
                    Button(action: {
                        showModal.toggle()
                        haptics.impactOccurred()
                    }, label: {
                        ImportantRowView(color: .red, text1: "deleteAllClosedTasksRowBody".localized(), text2: "\("numberOfClosedTaskBodyDescription".localized()) \(closedTasks.count)", image: "trash.fill", rightIconShow: false)
                            .padding(.horizontal)
                        
                    })

                    // MARK: TAMAMLANANLAR TASKLAR
                    ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false, content: {
                        VStack(spacing: 0){
                            // TÜM TAMAMLANANLAR
                            ForEach(closedTasks) { task in
                                ListRowItemView(homeData: task) {
                                    homeData.editItem(item: task)
                                } editAction: {
                                    homeData.editItem(item: task)
                                } deleteAction: {
                                    context.delete(task)
                                    NotificationManager.istance.cancelNotification(idArray: ["\(task.content!)"])
                                }
                            }
                        }
                        
                    })
                    
                    Spacer()
                    
                }
                
                
                
                // MARK: POPUP
                if $showModal.wrappedValue {
                    
                    CustomPopup(showingModal: $showModal, popupText: "deleteAllClosedTasksPopupText".localized()) {
                        haptics.impactOccurred()
                        deleteAll()
                        try! context.save()
                        presentationMode.wrappedValue.dismiss()
                    }
                    
                }
            }
            .onAppear(){UITableView.appearance().backgroundColor = UIColor.clear}
            .sheet(isPresented: $homeData.isNewData, content: {NewDataView(homeData: homeData)})
    }
    
    
    
    // MARK: FUNTIONS
    
        private func deleteAll(){
    
            for item in closedTasks {
                context.delete(item)
            }
    
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    
}


// MARK: PREVIEW
struct ClosedTasks_Previews: PreviewProvider {
    static var previews: some View {
        ClosedTasks()
    }
}

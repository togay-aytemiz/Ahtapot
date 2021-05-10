//
//  Deneme.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 1.05.2021.
//

import SwiftUI
import UIKit

struct SearchView: View {
    // MARK: PROPERTIES
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var obj: observed
    
    @StateObject var homeData = HomeViewModel()

    let haptics = UIImpactFeedbackGenerator()

    
    // FETCHING DETAILS
    @Environment(\.managedObjectContext) var context
    
    // Fetch All Tasks
    @FetchRequest(
        entity: Task.entity(),
        sortDescriptors: [NSSortDescriptor(key: "date",ascending: true)],
        animation: .spring())
    var results : FetchedResults<Task>
    
    
    @FetchRequest(
        entity: Task.entity(),
        sortDescriptors: [NSSortDescriptor(key: "date",ascending: true)],
        predicate: .OpenTasks(),
        animation: .spring())
    var allOpenTasks : FetchedResults<Task>


    @State private var searchTerm: String = ""
    @State private var placeholderForSearch = "Ara..."

    
    // PICKER
    @State private var selectedPickerOption = 0
    let pickerOptions = ["Bekleyenler", "Tümü"]
    
    
    
    
    
    // MARK: BODY
    var body: some View {
        
        ZStack {
            
            Utils.isDarkMode ? Color.black.edgesIgnoringSafeArea(.all) : Color.white.edgesIgnoringSafeArea(.all)

            
            VStack{
                
                // MARK: SEARCH BAR
                HStack {

                        // SEARCH BAR ------ ICON + YAZI + EMPTY BUTTON
                        HStack{
                            
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 18, weight: .semibold, design: .rounded))
                                .foregroundColor(Color(Utils.AppColor1))
                                .padding(.leading, 4)
                            
                            ZStack(alignment: .leading){
                                if searchTerm == "" {
                                    Text("Görevler içinde ara...")
                                        .font(.system(.headline, design: .rounded))
                                        .foregroundColor(!Utils.isDarkMode ? Color.gray : .white.opacity(0.6))
                                        .padding(.leading, 5)

                                }
                                
                                MultiTextField(text: $searchTerm, color: Color(Utils.AppColor1))
                                    .animation(.easeIn)
                            }
                            
                            Spacer()
                            
                            Group{
                            if searchTerm != "" {
                                Button(action: {
                                    searchTerm = ""
                                    //haptics.impactOccurred()
                                }, label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .font(.headline)
                                        .foregroundColor(Color.gray)
                                        .padding(.trailing, 4)
                                    
                                })
                            }
                            }
                            
                            
                        }
                        //.frame(height: 36)
                        .frame(height: self.obj.size < 80 ? self.obj.size : 80)
                        .padding(5)
                        .background(Utils.isDarkMode ? Color.gray.opacity(0.5) : Color(Utils.AppColor1).opacity(0.1))
                        .cornerRadius(12)
                    
                    
                    
                    
                    Spacer()

                    
                    // VAZGEÇ BUTONU
                    
                    Button(action: {
                        haptics.impactOccurred()
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Vazgeç")
                            .foregroundColor(Color(Utils.AppColor1))
                            .fontWeight(.semibold)
                    })

                }.padding()
       

                
                // MARK: SONUÇLAR
                if (results.filter({searchTerm.isEmpty ? true : $0.content!.localizedCaseInsensitiveContains(self.searchTerm)}).count) == 0 {
                    
                    VStack {
                        
                        Spacer()
                        EmptyViewIllustrations(image: "NoSearchView", text: "'\(searchTerm)' için arama sonucu bulamadık 😢\nLütfen başka bir arama terimi ile dene", header: "SONUÇ BULUNAMADI")
                        Spacer()
                        Spacer()
                    }
                    
                }
                else {
                    
                    ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false, content: {

                        
                        // PICKER
                        Group {
                            Picker(selection: $selectedPickerOption, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/, content: {
                                Text("Bekleyenler (\(allOpenTasks.filter({searchTerm.isEmpty ? true : $0.content!.localizedCaseInsensitiveContains(self.searchTerm)}).count))").tag(0)
                                Text("Tümü (\(results.filter({searchTerm.isEmpty ? true : $0.content!.localizedCaseInsensitiveContains(self.searchTerm)}).count))").tag(1)
                            })
                            .pickerStyle(SegmentedPickerStyle())
                            .labelsHidden()
                            .padding(.bottom, 5)
                            .frame(maxWidth: 300)
                            .onTapGesture {
                                haptics.impactOccurred()
                                if self.selectedPickerOption == 0 {
                                    self.selectedPickerOption = 1
                                } else {
                                    self.selectedPickerOption = 0
                                }
                            }
                            .colorScheme(Utils.isDarkMode ? .dark : .light)
                        }
                        
                        // BEKLEYENLER
                        if selectedPickerOption == 0 {
                            
                            Spacer()
                            if allOpenTasks.count > 0 {
                                VStack(spacing: 0) {
                                    ForEach(allOpenTasks.filter({searchTerm.isEmpty ? true : $0.content!.localizedCaseInsensitiveContains(self.searchTerm)})) { task in
                                        
                                        
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
                            } else {
                                VStack {
                                    Spacer()
                                    Text("Bekleyen hiç görevin yok 💪🏻")
                                        .font(.system(.headline, design: .rounded))
                                        .fontWeight(.light)
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(Utils.isDarkMode ? Color.white.opacity(0.7) : Color.black.opacity(0.6))
                                        .lineLimit(2)
                                        .fixedSize(horizontal: false, vertical: true)
                                    Spacer()
                                    Spacer()
                                }
                            }
                            
                            
                            Spacer()
                            
                        }
                        
                        // TÜMÜ
                        else {
                            
                            
                            VStack(spacing: 0) {
                                ForEach(results.filter({searchTerm.isEmpty ? true : $0.content!.localizedCaseInsensitiveContains(self.searchTerm)})) { task in
                                    
                                    
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
                        }
                        
                    })
                }
            }
            .onAppear(){ UITableView.appearance().backgroundColor = UIColor.clear }
            .sheet(isPresented: $homeData.isNewData, content: {
                NewDataView(homeData: homeData)
                
            })
            .padding(.top)
            .padding(.bottom)
            .padding(.bottom)
            .onTapGesture {
                hideKeyboard()
        }
        }
    }
}
 



struct Deneme_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(observed())
    }
}





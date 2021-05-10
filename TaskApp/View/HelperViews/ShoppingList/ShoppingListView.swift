//
//  ShoppingListView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 28.04.2021.
//

import SwiftUI

struct ShoppingListView: View {
    // MARK: PROPERTIES
    
    
    @StateObject var shoppingList = ShoppingList()
    let haptics = UIImpactFeedbackGenerator()
    @State private var showModal: Bool = false

    @Environment(\.presentationMode) var presentationMode
    
    @AppStorage("showClosed") private var showClosed: Bool = true
    @AppStorage("isFirstTimeShoppingList") private var isFirstTimeShoppingList: Bool = true
    
    
    // Fetching Data from CoreData
    @Environment(\.managedObjectContext) var context
    
    @FetchRequest(entity: Shopping.entity(),sortDescriptors: [NSSortDescriptor(key: "date",ascending: false)], animation: .spring()) var list : FetchedResults<Shopping>

    @FetchRequest(entity: Shopping.entity(),sortDescriptors: [NSSortDescriptor(key: "date",ascending: false)],predicate: .OpenTasks(), animation: .spring()) var allOpenTasks : FetchedResults<Shopping>

    @State private var isListOpen: Bool = true
    
    
    // MARK: BODY
    var body: some View {
        NavigationView{
            
            ZStack(alignment: .bottom) {
                
                
                Utils.isDarkMode ? Color.black.edgesIgnoringSafeArea(.all) : Color.white.edgesIgnoringSafeArea(.all)

                
                
                // MARK: MAIN VIEW
                VStack {
                    
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
                                    Text("Kapat")
                                        .font(.system(.headline, design: .rounded))
                                        .fontWeight(.semibold)
                                }
                            })
                            .foregroundColor(Utils.isDarkMode ? Color.white : Color.black)
                            
                            Spacer()
                            
                            
                            // RIGHT
                            Button(action: {
                                showModal.toggle()
                                haptics.impactOccurred()
                            }, label: {
                                HStack(spacing: 2) {
                                    Image(systemName: "trash.fill")
                                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                                    
                                    Text("Listeyi Temizle")
                                        .font(.system(.headline, design: .rounded))
                                        .fontWeight(.semibold)
                                    
                                }
                            })
                            .disabled(list.count == 0)
                            .accentColor(.red)
                            .opacity(list.count > 0 ? 1 : 0)
                        }
                        .padding()
                        
                    }
                    

                    NavigationBarView(title: "Alışveriş Listem", showDate: false)

                        .padding(.horizontal, 15)
                        .foregroundColor(Utils.isDarkMode ? Color.white : Color.black)

                    
                    
                    
                    
                    // MARK: SOME STATS
                    if list.count > 0 {
                        
                        TitleView(title: "", number1: (list.count - allOpenTasks.count), number2: list.count, barShown: true, isTwoNumber: true)
                            .padding(.top, -25)
                        
                        if (list.count - allOpenTasks.count) > 0 {
                            Group{
                                Button(action: {
                                    haptics.impactOccurred()
                                    showClosed.toggle()
                                }, label: {
                                    HStack {
                                        Image(systemName: showClosed ? "eye.slash.fill" : "eye.fill")
                                            .font(.caption)
                                        Text(showClosed ? "Aldıklarımı Gizle" : "Aldıklarımı Göster")
                                            .font(.system(.footnote, design: .rounded))
                                            .multilineTextAlignment(.trailing)
                                        
                                        
                                        
                                    }
                                    .animation(.easeIn)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 12)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                    .foregroundColor(.accentColor)
                                    .shadow(color: Color(.black).opacity(0.3), radius: 8, x: 0.0, y: 6.0)
                                    
                                })
                                
                            }
                            .padding(.bottom)
                            
                            
                        }
                    }

                    // MARK: CONTENT

                    
                    
                    if list.count == 0 {
                        //ShoppingBagEmptyView()
                        Spacer()
                        EmptyViewIllustrations(image: "cart", text: "Alışveriş listen boş.\nAşağıdan ekleyebilirsin 👇🏻", header: "LİSTEN BOŞ")
                        Spacer()
                        Spacer()
                        Spacer()
                        
                    }
                    
                    else {
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            
                            
                            ForEach(showClosed ? list : allOpenTasks) { item in
                                ShoppingListRowView(list: item) {
                                    context.delete(item)
                                    try! context.save()
                                }
                            }
                            
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 120)
                        
                    }
                    
                   
                }
                .onTapGesture {
                    hideKeyboard()
                }
              
                

                // MARK: ADD FIELD & BUTTON
                AddShoppingTextFieldView(content: $shoppingList.content, action: {
                    shoppingList.firstTimeAddItem(context: context)
                })
                
              
                .navigationBarTitle("Alışveriş Listem", displayMode: .automatic)
                .navigationBarHidden(true)
                
                
                // MARK: POPUP
                if $showModal.wrappedValue {
                    
                    CustomPopup(showingModal: $showModal, popupText: "Listendeki her şey silinecek. Bu işlem geri alınamaz") {
                        haptics.impactOccurred()
                        deleteAll()
                        try! context.save()
                    }
                    
                }
                
            }
            .sheet(isPresented: $isFirstTimeShoppingList, content: {
                FirstTimeShoppingList(isFirstTimeShoppingList: $isFirstTimeShoppingList)
            })
            
        }
    }
    
    private func deleteAll(){

        for item in list {
            context.delete(item)
        }

        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { list[$0] }.forEach(context.delete)

            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
}

// MARK: PREVIEW
struct ShoppingListView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListView()
    }
}

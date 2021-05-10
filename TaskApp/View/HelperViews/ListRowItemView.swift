//
//  ListRowItemView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 18.04.2021.
//

import SwiftUI

struct ListRowItemView: View {
    // MARK: PROPERTIES
    
    @Environment(\.managedObjectContext) var context
    @ObservedObject var homeData : Task

    
    let haptics = UIImpactFeedbackGenerator()

    
    var action: () -> Void
    var editAction: () -> Void
    var deleteAction: () -> Void
    
    
    // tamamlananların üzerini çizme
    var strikeThrough: Bool {
        if homeData.completion {
            return true
        } else {
            return false
        }
    }

    // Günü geçenleri farklı renklendirme kontrolü
    var isDateOlder: Bool {
        if homeData.date! < Date() {
            return true
        } else {
            return false
        }
    }
    
    
    // MARK: BODY
    var body: some View {

        
        Button(action: {
            action()
            haptics.impactOccurred()
        }, label: {
            
        
        HStack {
            
            // MARK: TOGGLE
            Toggle(isOn: $homeData.completion){
                
               
                    
                VStack(alignment: .leading, spacing: 2) {
                    
                    
                    Text(homeData.content ?? "")
                        .strikethrough(strikeThrough)
                        .font(.system(.headline, design: .rounded))
                        .fontWeight(.medium)
                        .foregroundColor(homeData.completion ? (Utils.isDarkMode ? Color.white.opacity(0.3) : Color.gray.opacity(0.5)) : (Utils.isDarkMode ? Color.white : Color.black))
                        .animation(.default)
                        .lineLimit(1)
                    
                    
                    
                    
                    HStack(spacing: 2) {
                        Image(systemName: "alarm")
                            .font(.system(.caption2, design: .rounded))
                        
                        Text(homeData.date ?? Date(), formatter: miniDateAndTimeFormat)
                            .font(.system(.subheadline, design: .rounded))
                            .fontWeight(.light)
                            .scaledToFit()
                            .minimumScaleFactor(0.7)
                    }
                    .foregroundColor(homeData.completion ? (Utils.isDarkMode ? Color.white.opacity(0.3) : Color.gray.opacity(0.5)) : (Utils.isDarkMode ? Color.white.opacity(0.7) : Color.gray))

                    
                    
                    
                    
                    
                }
                .padding(.vertical, 12)
            
                
                
                
            }
            .toggleStyle(CheckBoxStyle())
            .onReceive(homeData.objectWillChange, perform: { _ in
                if self.context.hasChanges {
                    homeData.isRemindMe = false
                    NotificationManager.istance.cancelNotification(idArray: ["\(homeData.content!)"])
                    try? self.context.save()
                }
            })
            
            
            Spacer()
            
            
            
            
            Button(action: {
                action()
                haptics.impactOccurred()

            }, label: {
                HStack {
                    // CategoryView(color: Color.purple)
                    if homeData.isRemindMe {
                        
                        Image(systemName: !isDateOlder ? "bell.fill" : "bell.slash.fill")
                            .foregroundColor(!isDateOlder ? Color("Color2B") : Color.gray.opacity(0.5))
                            .shadow(color: Color("Color2B").opacity(!isDateOlder ? 0.4 : 0), radius: 8, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 6.0)
                        
                    }

                    
                    Image(systemName: "chevron.right")
                        .accentColor(homeData.completion ? (Utils.isDarkMode ? Color.white.opacity(0.3) : Color.gray.opacity(0.5)) : Color(Utils.AppColor1))
                        .font(.system(size: 14, weight: .semibold, design: .rounded))

                }
            })
            .padding()
            
        } // HSTACK
        
        
        // kendi içinde padding
        .padding(.leading)
        .background(Utils.isDarkMode ? Color.gray.opacity(0.3) : Color.gray.opacity(0.12))
        .cornerRadius(12)
        .contextMenu(ContextMenu(menuItems: {
            Button(action: {
                haptics.impactOccurred()
                editAction()
            }, label: {
                Label(
                    title: { Text("Görev Düzenle") },
                    icon: { Image(systemName: "rectangle.and.pencil.and.ellipsis") }
                )
            })
            Button(action: {
                //showModal.toggle()
                haptics.impactOccurred()
                deleteAction()
            }, label: {
                Label(
                    title: { Text("Sil") },
                    icon: { Image(systemName: "trash") }
                )
            })
        }))

        
        // Ekrandan padding
        .padding(.horizontal)
        .padding(.top, 6)
            
        })
    }
}







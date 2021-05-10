//
//  ShoppingListRowView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 29.04.2021.
//

import SwiftUI

struct ShoppingListRowView: View {
    // MARK: PROPERTIES
    
    
    @Environment(\.managedObjectContext) var context
    @ObservedObject var list : Shopping
    

    
    
    // OTHERS
    let haptics = UIImpactFeedbackGenerator()
    var action: () -> Void
    
    

    
    var openTaskTextView: Color {
        if Utils.isDarkMode {
            return .white
        } else {
            return .black
        }
    }
    
    var completion: Color {
        if Utils.isDarkMode {
            return Color.white.opacity(0.5)
        } else {
            return Color.gray.opacity(0.5)
        }
    }
    
    
    
    // MARK: BODY
    var body: some View {
        
        // MARK: TOGGLE
        VStack {
            HStack {
                Toggle(isOn: $list.completion){

                        
                    VStack(alignment: .leading, spacing: 4) {

                        Text(list.content ?? "")
                            .strikethrough(list.completion ? true : false)
                            .font(.system(.body, design: .rounded))
                            .foregroundColor(list.completion ? completion : openTaskTextView)
                            .animation(.default)
                            .multilineTextAlignment(.leading)
                        
                        
                    }
                    .padding(.vertical, 12)
                    
                    
                }
                .toggleStyle(CheckBoxStyle())
                .onReceive(list.objectWillChange, perform: { _ in
                    if self.context.hasChanges {
                        try? self.context.save()
                        haptics.impactOccurred()
                    }
                })
                
                Spacer()
                
                
                Button(action: {
                    action()
                    haptics.impactOccurred()
                }, label: {
                    Image(systemName: "trash.fill")
                        .font(.system(.footnote, design: .rounded))
                        .foregroundColor(list.completion ? completion : openTaskTextView.opacity(0.5))
                })
                
            }
            .onTapGesture {
                list.completion.toggle()
                try? self.context.save()
                haptics.impactOccurred()
            }
            
            
            Divider()
                .foregroundColor(Utils.isDarkMode ? Color.white.opacity(1) : Color.gray.opacity(1))
        }
        
        
        
    }
}


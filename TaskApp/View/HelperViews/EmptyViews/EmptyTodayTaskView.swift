//
//  EmptyTodayTaskView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 23.04.2021.
//

import SwiftUI

struct EmptyTodayTaskView: View {
    // MARK: PROPERTIES
    
    
    let haptics = UIImpactFeedbackGenerator()
    
    // COLORS
    //@AppStorage("appColor1") private var AppColor1: String = "Color1A"
    //@AppStorage("appColor2") private var AppColor2: String = "Color1B"

    
    // BÜGNLÜK TAMAM MI TEBRİK mi ayrımı
    let isCongratz: Bool
    
    var filledColor: Color {
        if isCongratz {
            return Color(Utils.AppColor1)
        } else {
            return .blue
        }
    }
    
    
    var action: () -> Void

    
    
    
    
    // MARK: BODY
    var body: some View {
        
        HStack{
            Spacer()
            Label(
                title: { Text("addNewTasksEmptyView".localized())
                    .font(.system(.body, design: .rounded))
                    .fontWeight(.semibold)
                    
                    
                },
                icon: { Image(systemName: "plus.circle.fill")
                    .font(.title3)
                }
            )
            .foregroundColor(Utils.isDarkMode ? Color.white : Color(Utils.AppColor1))
            .padding()
            .accentColor(Color(Utils.AppColor1))
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 30)
        .background(filledColor.opacity(0.1))
        .cornerRadius(12)
        .onTapGesture(perform: {
            action()
            haptics.impactOccurred()
        })
      
    }
}


// MARK: PREVIEW
struct EmptyTodayTaskView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyTodayTaskView(isCongratz: true, action: {
            //
        })
        .preferredColorScheme(.light)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}







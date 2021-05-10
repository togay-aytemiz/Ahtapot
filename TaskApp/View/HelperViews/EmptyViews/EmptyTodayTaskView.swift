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
        
        
        Button(action: {
            action()
            haptics.impactOccurred()
            
        }, label: {
            Label(
                title: { Text("Yeni Görev Ekle")
                    .font(.system(.body, design: .rounded))
                    .fontWeight(.semibold)
                    
                },
                icon: { Image(systemName: "plus.circle.fill")
                    .font(.title3)
                }
            )
        })
        .accentColor(Color(Utils.AppColor1))
        .padding()
        .frame(maxWidth: 640)
        .background(filledColor.opacity(0.1))
        .cornerRadius(12)
      
    }
}


// MARK: PREVIEW
struct EmptyTodayTaskView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyTodayTaskView(isCongratz: true, action: {
            //
        })
        .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}





//VStack(spacing: 6) {
//    Text(isCongratz ? "🥳" : "😴")
//        .font(.system(.largeTitle, design: .rounded))
//
//    VStack(spacing: 4) {
//        Text(isCongratz ? "HARİKASIN!" : "..ZZzz..!")
//            .font(.system(.title3, design: .rounded))
//            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
//            .foregroundColor(Color.primary)
//
//
//        Text(isCongratz ? "Bugün yapılacakların hepsini tamamladın" : "Birileri bugün biraz tembellik ediyor")
//            .font(.system(.body, design: .rounded))
//            .foregroundColor(Color.primary)
//            .multilineTextAlignment(.center)
//
//        Button(action: {
//            action()
//            haptics.impactOccurred()
//
//        }, label: {
//            Label(
//                title: { Text("Yeni Görev Ekle")
//                    .font(.system(.body, design: .rounded))
//                    .fontWeight(.semibold)
//
//                },
//                icon: { Image(systemName: "plus.circle.fill")
//                    .font(.title3)
//                }
//            )
//        })
//        .padding(.top, 6)
//        .accentColor(Color(AppColor1))
//    }
//
//}
//.padding()
//.frame(maxWidth: 640)
//.background(filledColor.opacity(0.1))
//.cornerRadius(12)

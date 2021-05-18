//
//  SideMenuOptionView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 10.05.2021.
//

import SwiftUI

struct SideMenuOptionView: View {
    // MARK: PROPERTIES
    
    @Binding var isShowingSideMenu: Bool
    
    var isSelectedTab: Bool = true
    
    var image : Image = Image("home")
    var text: String = "Bugün"
    var taskNumber = 0
    var isTaskNumberShow = false
    var descriptionText : String = ""
    
    var action: () -> Void
    let haptics = UIImpactFeedbackGenerator()

    
    
    
    
    
    
    
    
    // MARK: BODY
    var body: some View {
        
        Button(action: {
            withAnimation(.spring()){
                action()
                haptics.impactOccurred()
                isShowingSideMenu = false
            }
            
        }, label: {
            HStack {
                HStack(alignment: .center, spacing: 12){
                    image
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                    
                    VStack(alignment: .leading) {
                        Text(text)
                            .font(.system(.headline, design: .rounded))
                            .fontWeight(.semibold)
                            .lineLimit(1)
                            .minimumScaleFactor(0.1)
                        
                        if descriptionText != ""  {
                            Text(descriptionText)
                                .font(.system(.footnote, design: .rounded))
                                .fontWeight(.light)
                                .foregroundColor(Color.white)
                        }
                    }
                    
                    
                    
                    if isTaskNumberShow {
                        Text("\(taskNumber)")
                            .font(.caption)
                            .frame(width: 24, height: 24)
                            .background(Color.white.opacity(0.8))
                            .clipShape(Circle())
                            .foregroundColor(Color(Utils.AppColor1))
                            .opacity(taskNumber > 0 ? 1 : 0.4)
                    }
                    
                    
                    
                }
                .padding()
                .padding(.leading)
                .foregroundColor(.white)
                
                Spacer()
            }
        })
        .background(Color.white.opacity(isSelectedTab ? 0.2 : 0).edgesIgnoringSafeArea(.all))
        
        
        
    }
}



// MARK: PREVIEW
struct SideMenuOptionView_Previews: PreviewProvider {
    static var previews: some View {
        
       
        
        SideMenuOptionView(isShowingSideMenu: .constant(true), action: {
            //
        })
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Utils.AppThemeBackgroundColor.edgesIgnoringSafeArea(.all))
    }
}

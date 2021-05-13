//
//  FirstTimeShoppingList.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 29.04.2021.
//

import SwiftUI

struct FirstTimeShoppingList: View {
    // MARK: PROPERTIES
    
    @Binding var isFirstTimeShoppingList: Bool
    @Environment(\.presentationMode) var presentationMode
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @AppStorage("appColor1") private var AppColor1: String = "Color1A"
    @AppStorage("appColor2") private var AppColor2: String = "Color1B"
    
    let haptics = UIImpactFeedbackGenerator()

    
    
    // MARK: BODY
    var body: some View {
        
        ZStack {
            
            isDarkMode ? Color.black.edgesIgnoringSafeArea(.all) : Color.white.edgesIgnoringSafeArea(.all)

            
            VStack(alignment: .center){
                Spacer()
                Spacer()
                HStack {
                    Spacer()
                    Text("🤗🛍\n \("welcomeShoppingListHeader".localized())")
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.heavy)
                        .foregroundColor(isDarkMode ? Color.white : Color.primary)
                        .multilineTextAlignment(.center)
                        .lineLimit(3)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }
                .padding(.vertical)
                Spacer()
                
                VStack(alignment: .leading, spacing: 40) {
                    
                    
                    ListItem(
                        image: "gift.fill",
                        title: "shoppingListClaimHeader1".localized(),
                        subText: "shoppingListClaimDescription1".localized(),
                        color: Color.blue)
                    
                    ListItem(
                        image: "hands.sparkles.fill",
                        title: "shoppingListClaimHeader2".localized(),
                        subText: "shoppingListClaimDescription2".localized(),
                        color: Color.orange)
                    
                    ListItem(
                        image: "arrow.left.arrow.right.circle.fill",
                        title: "shoppingListClaimHeader3".localized(),
                        subText: "shoppingListClaimDescription3".localized(),
                        color: Color.green)
         
                    
                }
                .padding()

                
                Spacer()
                
                Button(action: {
                    isFirstTimeShoppingList = false
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Label(
                        title: { Text("letsGo".localized())
                            .font(.system(.headline, design: .rounded))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        },
                        icon: { Image(systemName: "arrow.right.circle.fill")
                            .font(.system(.headline, design: .rounded))
                            .foregroundColor(.white)
                            
                        })
                        .padding(.vertical)
                        .frame(maxWidth: 400)
                        .background(Utils.AppThemeBackgroundColor)
                        .cornerRadius(8)
                        .shadow(color: Color(AppColor1).opacity(0.3), radius: 5, x: 0, y: 5 )
                })
                .padding()
                .padding(.horizontal)
                
                Spacer()
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width-30, alignment: .center)
            .padding(.bottom)
        }
        

    }
}


// MARK: PREVIEW
struct FirstTimeShoppingList_Previews: PreviewProvider {
    static var previews: some View {
        FirstTimeShoppingList(isFirstTimeShoppingList: .constant(true))
            
    }
}

struct ListItem: View {
    
    
    var image : String
    var title: String = "title"
    var subText: String = "Lorem ipsum askld maslk mdasldk masdl masld kmasldkmaslkdm al kdmasl kmasdl masldk masldk mas asdas asd asd asd asd asd as as "
    var color : Color
    
    var body: some View {
        HStack {
            
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .minimumScaleFactor(0.5)
                .foregroundColor(color)
                .padding(.trailing, 10)
                .shadow(color: color.opacity(0.1), radius: 5, x: 0, y: 5 )

            
            VStack(alignment: .leading, spacing: 2){
                Text(title)
                    .font(.system(.headline, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(Utils.isDarkMode ? Color.white : Color.primary)
                Text(subText)
                    .font(.system(.subheadline, design: .rounded))
                    .fontWeight(.regular)
                    .foregroundColor(Utils.isDarkMode ? Color.white.opacity(0.8) : Color.secondary)
                    .layoutPriority(0)
                    .lineLimit(4)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}

//
//  AddShoppingTextFieldView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 29.04.2021.
//

import SwiftUI

struct AddShoppingTextFieldView: View {
    // MARK: PROPERTIES
    
    @Environment(\.managedObjectContext) var context
    @StateObject var shoppingList = ShoppingList()


    
    let haptics = UIImpactFeedbackGenerator()

    @Binding var content: String
    @State private var textfieldPlaceholder: String = "Ne alacaksın?"

    
    var action: () -> Void

    
    // MARK: BODY
    var body: some View {
        
        ZStack(alignment: .top) {
            
            
            VStack {
                HStack() {
                    
                    
                    ZStack {
                        
                        if content == "" {
                            TextField("", text: $textfieldPlaceholder)
                                .font(.system(.headline, design: .rounded))
                                .foregroundColor(Utils.isDarkMode ? .white.opacity(0.7) : .black.opacity(0.5))
                        }
                        
                        
                        TextField("", text:$content)
                            .font(.system(.headline, design: .rounded))
                            .disableAutocorrection(true)
                            .autocapitalization(.sentences)
                            .foregroundColor(Utils.isDarkMode ? .white : .black)
                            .colorScheme(Utils.isDarkMode ? .dark : .light)

                        
                    }



                    Button(action: {
                        haptics.impactOccurred()
                        action()
                    }, label: {
                        Utils.AppThemeBackgroundColor
                            .mask(Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            ).frame(width: 40, height: 40, alignment: .center)
                    })
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(color: Color(Utils.AppColor1).opacity(0.3), radius: 8, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 6.0)
                    .disabled(content.isEmpty)
                    .opacity(content.isEmpty ? 0.3 : 1 )
    
                    
                }
                .padding()
                .background(Color(Utils.AppColor1).opacity(Utils.isDarkMode ? 0.3 : 0.07))
                .cornerRadius(12)

            }
            .padding()
            .background(Utils.isDarkMode ? Color.black : Color.white)
            
            
            //Divider()
        }
    }
}


// MARK: PREVIEW
struct AddShoppingTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        AddShoppingTextFieldView(content: .constant("Content"), action: {
            //
        })
            .previewLayout(.sizeThatFits)
    }
}

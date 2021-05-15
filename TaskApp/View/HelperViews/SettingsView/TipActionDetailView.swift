//
//  TipActionDetailView.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 15.05.2021.
//

import SwiftUI



struct TipActionDetailView: View {
    // MARK: PROPERTIES
    
    @EnvironmentObject private var store: Store
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false

    let haptics = UIImpactFeedbackGenerator()
    
    // MARK: BODY
    var body: some View {
        
        ZStack {
            
            Utils.isDarkMode ? Color.black.edgesIgnoringSafeArea(.all) : Color.white.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center) {
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
                
                
                // MARK: PURCHASE CONTENT
                Image("gift")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 64, height: 64)
                    .padding()
                    .background(Utils.AppThemeBackgroundColor.opacity(0.2))
                    .cornerRadius(12)
                    .padding(.top)
                
                
                VStack(spacing: 10) {
                    Text("Give us a gift")
                        .font(.system(.title, design: .rounded))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Utils.isDarkMode ? .white : .black)
                    
                    
                    Text("Ahtapot is a completely free app and it will stay free forever, you can be sure of that. By choosing one of the gifts below, you can encourage us to bring this app to better places for you.")
                        .font(.system(.body, design: .rounded))
                        .fontWeight(.regular)
                        .multilineTextAlignment(.center)
                        .frame(width: UIScreen.main.bounds.width - 50)
                        .lineLimit(4)
                        .minimumScaleFactor(0.1)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(Utils.isDarkMode ? .white : .black)
                        .opacity(0.7)

                }
                
                
                ZStack{
                    
                    Divider()
                        
                    
                    
                    Text("You can give more than once 🎁")
                        .font(.system(.headline, design: .rounded))
                        .fontWeight(.semibold)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .background(Utils.AppThemeBackgroundColor)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                    
                }
                .padding(.vertical)
                .padding(.vertical)

                
                
                
                
                
                // MARK: PURCHASE OPTIONS
//                ForEach(store.allGifts, id: \.self) { gift in
//                    Group {
//                        GiftRow(gift: gift) {
//                            if let product = store.product(for: gift.id) {
//                                store.purchaseProduct(product)
//                            }
//                        }
//                    }
//                }
                
                VStack(spacing: 16){
                    GiftRowView()
                    GiftRowView()
                    GiftRowView()
                }
                .padding()
                    
                
                
                
                Spacer()
            }
        }
        
        
        
        

        
    }
}


// MARK: PREVIEW
struct TipActionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TipActionDetailView()
           
    }
}



struct GiftRow: View {
    let gift: Gift
    let action: () -> Void
    
    var body: some View {
        HStack{
            ZStack{
                Image(gift.imageName ?? "gift")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                
            }
            
            VStack(alignment: .leading) {
                Text(gift.title)
                Text(gift.description)
            }
            
            Spacer()
            
            Button(action: {
                action()
            }, label: {
                Text(gift.price!)
                    .padding()
                    .foregroundColor(.blue)
            })
        }
    }
}

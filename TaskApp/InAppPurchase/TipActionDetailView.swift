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
    @Binding var selectedTab: String

    let haptics = UIImpactFeedbackGenerator()
    
    // MARK: BODY
    var body: some View {
        
        ZStack(alignment: .top) {
            
            Utils.isDarkMode ? Color.black.edgesIgnoringSafeArea(.all) : Color.white.edgesIgnoringSafeArea(.all)
            
            
            
            
            
            // MARK: CONTENT
            VStack(alignment: .center) {
                
                
                
                // MARK: CONTENT
                ScrollView(.vertical, showsIndicators: false) {
                    
                    // MARK: MAIN
                    VStack{
                        
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
                            Text("giveUsAGift".localized())
                                .font(.system(.title, design: .rounded))
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .foregroundColor(Utils.isDarkMode ? .white : .black)
                            
                            
                            Text("giveUsAGiftDesctription".localized())
                                .font(.system(.body, design: .rounded))
                                .fontWeight(.regular)
                                .multilineTextAlignment(.center)
                                .frame(width: UIScreen.main.bounds.width - 50)
                                .lineLimit(5)
                                .minimumScaleFactor(0.1)
                                .fixedSize(horizontal: false, vertical: true)
                                .foregroundColor(Utils.isDarkMode ? .white : .black)
                                .opacity(0.7)

                        }
                        
                        
                        // MARK: GIVE MORE THAN ONCE MESSAGE
                        ZStack{
                            
                            Divider()
                                
                            
                            
                            Text("giveUsAGift_MoreGift".localized())
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
                        ForEach(store.allGifts, id: \.self) { gift in
                            Group {
                                GiftRowView(gift: gift) {
                                    store.loadingState = true

                                    if let product = store.product(for: gift.id) {
                                        
                                        store.purchaseProduct(product)
                                    }
                                }
                            }
                        }
                        
                        
                        Spacer()
                    }
                    .padding(.top)
                    .padding(.top)
                    
                    
                    // MARK: FOOTER
                    Group {
                        Text("giftFooterDescription".localized())
                        .font(.system(.subheadline, design: .rounded))
                        .fontWeight(.regular)
                        .multilineTextAlignment(.center)
                        .frame(width: UIScreen.main.bounds.width - 50)
                        .lineLimit(4)
                        .minimumScaleFactor(0.1)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(Utils.isDarkMode ? .white : .black)
                        .opacity(0.7)
                    }
                    
                    
                    
                    
                    .padding(.vertical)
                    .padding(.bottom, 60)
                }
            }
            
            // MARK: HEADER BUTTONS
            Group{
                HStack {
                    Spacer()
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                        haptics.impactOccurred()
                    },label: {
                        HStack(spacing: 2) {
                            Image(systemName: "chevron.down")
                                .font(.system(size: 18, weight: .semibold, design: .rounded))
                                .padding()
                                .background(Color(.systemGray6))
                                .clipShape(Circle())
                        }
                    })
                    .foregroundColor(.primary)
                    
                    
                }
                .padding()
            }
            
            
            
            
            
            
            // MARK: POPUP
            if $store.successfullyPurchased.wrappedValue {
                
                SuccesfullyPurchasedPopup(showingModal: $store.successfullyPurchased, selectedTab: $selectedTab) {
                    presentationMode.wrappedValue.dismiss()
                    haptics.impactOccurred()
                }

                
            }
            
            if $store.loadingState.wrappedValue {
                StoreLoadingView()
            }
            
        }
        
    }
}


// MARK: PREVIEW
struct TipActionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TipActionDetailView(selectedTab: .constant("settings"))
           
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

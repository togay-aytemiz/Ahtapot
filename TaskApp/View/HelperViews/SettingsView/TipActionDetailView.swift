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
    
    
    // MARK: BODY
    var body: some View {
        
        VStack{
            Text("asdasda")
        }
        
        
//            List(store.allGifts, id: \.self) { gift in
//                Group {
//                    GiftRow(gift: gift) {
//                        if let product = store.product(for: gift.id) {
//                            store.purchaseProduct(product)
//                        }
//                    }
//                }
//            }
        
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

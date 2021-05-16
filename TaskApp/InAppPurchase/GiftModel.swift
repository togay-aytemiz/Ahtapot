//
//  GiftModel.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 15.05.2021.
//

import Foundation
import StoreKit

struct Gift: Hashable {
    let id : String
    let title : String
    let description : String
    var isPurchased: Bool
    var price : String?
    let locale: Locale
    let imageName: String?
    
    lazy var formatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .currency
        nf.locale = locale
        return nf
    }()
    
    init(product: SKProduct, isPurchased: Bool = true) {
        self.id = product.productIdentifier
        self.title = product.localizedTitle
        self.description = product.localizedDescription
        self.isPurchased = isPurchased
        self.locale = product.priceLocale
        self.imageName = product.productIdentifier
        self.price = formatter.string(from: product.price)!
        
    }
}

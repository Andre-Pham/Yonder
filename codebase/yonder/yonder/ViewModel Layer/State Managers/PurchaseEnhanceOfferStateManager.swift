//
//  PurchaseEnhanceOfferStateManager.swift
//  yonder
//
//  Created by Andre Pham on 11/4/2022.
//

import Foundation

class PurchaseEnhanceOfferStateManager: ObservableObject {
    
    @Published var purchaseButtonActiveBindings: [Bool]
    
    init(offerCount: Int) {
        self.purchaseButtonActiveBindings = Array(repeating: false, count: offerCount)
    }
    
    func expandButton(at index: Int) {
        self.purchaseButtonActiveBindings[index] = true
    }
    
}

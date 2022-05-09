//
//  ShopKeeperCardView.swift
//  yonder
//
//  Created by Andre Pham on 8/2/2022.
//

import Foundation
import SwiftUI

struct ShopKeeperCardView: View {
    @ObservedObject var shopKeeperViewModel: ShopKeeperViewModel
    
    var body: some View {
        CardBody(name: self.shopKeeperViewModel.name) {
            CardInteractorTypeView()
            
            CardPriceRangeView(
                minPrice: self.shopKeeperViewModel.getLowestPrice(),
                maxPrice: self.shopKeeperViewModel.getHighestPrice())
            
            CardOfferCountView(offerCount: self.shopKeeperViewModel.purchasables.count)
        }
    }
}

struct ShopKeeperCardView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Yonder.backgroundMaxDepth
                .ignoresSafeArea()
            
            ShopKeeperCardView(shopKeeperViewModel: ShopKeeperViewModel(ShopKeeper(
                name: "Andre",
                description: "I sell pancakes and maple syrup!!",
                purchasableItems: [
                    PurchasableItem(item: Weapon(basePill: DamageBasePill(damage: 200, durability: 5), durabilityPill: DullingDurabilityPill(damageLostPerUse: 50)), stock: 5)
                ])))
        }
    }
}

//
//  ShopKeeperInspectView.swift
//  yonder
//
//  Created by Andre Pham on 9/5/2022.
//

import SwiftUI

struct ShopKeeperInspectView: View {
    @ObservedObject var shopkeeperViewModel: ShopKeeperViewModel
    
    var body: some View {
        InspectNPCBody(
            name: self.shopkeeperViewModel.name,
            description: self.shopkeeperViewModel.description,
            locationType: LocationType.shop
        ) {
            YonderText(text: "Offers", size: .inspectSheetTitle)
            
            InspectStatView(title: "Offers", value: self.shopkeeperViewModel.purchasables.count)
            
            YonderText(text: "Selling: \(self.shopkeeperViewModel.getOffersDescription())", size: .inspectSheetBody)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct ShopKeeperInspectView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            ShopKeeperInspectView(shopkeeperViewModel: ShopKeeperViewModel(ShopKeeper(
                name: "Andre",
                description: "I sell pancakes and maple syrup!!",
                purchasableItems: [
                    PurchasableItem(item: Weapon(basePill: DamageBasePill(damage: 200, durability: 5), durabilityPill: DullingDurabilityPill(damageLostPerUse: 50)), stock: 5)
                ])))
        }
    }
}

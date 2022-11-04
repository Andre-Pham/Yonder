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
            YonderText(text: Strings("inspect.title.offers").local, size: .inspectSheetTitle)
            
            InspectStatView(title: Strings("stat.offers").local, value: self.shopkeeperViewModel.purchasables.count)
            
            YonderText(text: "\(Strings("stat.description.selling").local): \(self.shopkeeperViewModel.getOffersDescription())", size: .inspectSheetBody)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct ShopKeeperInspectView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            ShopKeeperInspectView(shopkeeperViewModel: PreviewObjects.shopKeeperViewModel)
        }
    }
}

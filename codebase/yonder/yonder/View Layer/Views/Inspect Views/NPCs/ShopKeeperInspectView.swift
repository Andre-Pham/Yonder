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
            YonderText(
                text: Strings("inspect.title.selling").local,
                size: .inspectSheetTitle
            )
            
            YonderText(
                text: "\(self.shopkeeperViewModel.getOffersDescription())", 
                size: .inspectSheetBody
            )
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    return PreviewContentView {
        ShopKeeperInspectView(shopkeeperViewModel: PreviewObjects.shopKeeperViewModel)
    }
}

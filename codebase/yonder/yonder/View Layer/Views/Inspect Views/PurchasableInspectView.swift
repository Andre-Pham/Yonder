//
//  PurchasableInspectView.swift
//  yonder
//
//  Created by Andre Pham on 2/4/2022.
//

import SwiftUI

struct PurchasableInspectView: View {
    @ObservedObject var purchasableViewModel: PurchasableViewModel
    @ObservedObject var playerViewModel: PlayerViewModel
    
    var body: some View {
        if let itemViewModel = self.purchasableViewModel.getItemViewModel() {
            ItemInspectView(itemViewModel: itemViewModel, playerViewModel: self.playerViewModel)
        } else if let armorViewModel = self.purchasableViewModel.getArmorViewModel() {
            ArmorInspectView(armorViewModel: armorViewModel)
        } else  {
            let (name, description) = self.purchasableViewModel.getNameAndDescription()
            DefaultInspectView(name: name, description: description)
        }
    }
}

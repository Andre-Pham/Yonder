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
        switch purchasableViewModel.type {
        case .weapon, .potion, .consumable:
            if let itemViewModel = self.purchasableViewModel.getItemViewModel() {
                ItemInspectView(itemViewModel: itemViewModel, playerViewModel: self.playerViewModel)
            }
        case .armor:
            if let armorViewModel = self.purchasableViewModel.getArmorViewModel() {
                ArmorInspectView(armorViewModel: armorViewModel)
            }
        case .accessory:
            if let accessoryViewModel = self.purchasableViewModel.getAccessoryViewModel() {
                AccessoryInspectView(accessoryViewModel: accessoryViewModel)
            }
        }
    }
}

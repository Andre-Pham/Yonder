//
//  CollectLootView.swift
//  yonder
//
//  Created by Andre Pham on 17/7/2022.
//

import SwiftUI

struct CollectLootView: View {
    @ObservedObject var playerViewModel: PlayerViewModel
    @ObservedObject var lootViewModel: LootViewModel
    var overrideFinishText: String? = nil
    var pageGeometry: GeometryProxy
    
    var body: some View {
        Group {
            ForEach(self.lootViewModel.armorViewModelLoot, id: \.id) { armorViewModel in
                LootArmorButton(
                    armorViewModel: armorViewModel,
                    playerViewModel: self.playerViewModel,
                    lootViewModel: self.lootViewModel,
                    pageGeometry: self.pageGeometry
                )
            }
            
            ForEach(self.lootViewModel.accessoryViewModelLoot, id: \.id) { accessoryViewModel in
                LootAccessoryButton(
                    accessoryViewModel: accessoryViewModel,
                    playerViewModel: self.playerViewModel,
                    lootViewModel: self.lootViewModel,
                    pageGeometry: self.pageGeometry
                )
            }
            
            ForEach(self.lootViewModel.weaponViewModelLoot, id: \.id) { weaponViewModel in
                LootWeaponButton(
                    weaponViewModel: weaponViewModel,
                    playerViewModel: self.playerViewModel,
                    lootViewModel: self.lootViewModel,
                    pageGeometry: self.pageGeometry
                )
            }
            
            ForEach(self.lootViewModel.consumableViewModelLoot, id: \.id) { consumableViewModel in
                LootConsumableButton(
                    consumableViewModel: consumableViewModel,
                    playerViewModel: self.playerViewModel,
                    lootViewModel: self.lootViewModel,
                    pageGeometry: self.pageGeometry
                )
            }
            
            ForEach(self.lootViewModel.potionViewModelLoot, id: \.id) { potionViewModel in
                LootPotionButton(
                    potionViewModel: potionViewModel,
                    playerViewModel: self.playerViewModel,
                    lootViewModel: self.lootViewModel,
                    pageGeometry: self.pageGeometry
                )
            }
            
            if self.lootViewModel.goldLoot > 0 {
                LootGoldButton(
                    amount: self.lootViewModel.goldLoot,
                    playerViewModel: self.playerViewModel,
                    lootViewModel: self.lootViewModel
                )
            }
            
            YonderWideButton(text: self.overrideFinishText ?? Strings("button.finished").local) {
                // If it's a loot bag
                self.playerViewModel.finishLooting()
                // If it's a loot choice
                self.playerViewModel.locationViewModel.getFoeViewModel()?.lootChoiceViewModel?.discardLoot()
            }
        }
    }
}

struct CollectLootView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            PreviewContentView {
                VStack {
                    CollectLootView(playerViewModel: PreviewObjects.playerViewModel, lootViewModel: PreviewObjects.lootBagViewModel, pageGeometry: geo)
                }
            }
        }
    }
}

//
//  CollectLootView.swift
//  yonder
//
//  Created by Andre Pham on 17/7/2022.
//

import SwiftUI

struct CollectLootView: View {
    @ObservedObject var playerViewModel: PlayerViewModel
    @ObservedObject var lootBagViewModel: LootBagViewModel
    var pageGeometry: GeometryProxy
    
    var body: some View {
        Group {
            ForEach(self.lootBagViewModel.armorViewModelLoot, id: \.id) { armorViewModel in
                LootArmorButton(
                    armorViewModel: armorViewModel,
                    playerViewModel: self.playerViewModel,
                    lootBagViewModel: self.lootBagViewModel,
                    pageGeometry: self.pageGeometry
                )
            }
            
            ForEach(self.lootBagViewModel.accessoryViewModelLoot, id: \.id) { accessoryViewModel in
                LootAccessoryButton(
                    accessoryViewModel: accessoryViewModel,
                    playerViewModel: self.playerViewModel,
                    lootBagViewModel: self.lootBagViewModel,
                    pageGeometry: self.pageGeometry
                )
            }
            
            ForEach(self.lootBagViewModel.weaponViewModelLoot, id: \.id) { weaponViewModel in
                LootWeaponButton(
                    weaponViewModel: weaponViewModel,
                    playerViewModel: self.playerViewModel,
                    lootBagViewModel: self.lootBagViewModel,
                    pageGeometry: self.pageGeometry
                )
            }
            
            ForEach(self.lootBagViewModel.consumableViewModelLoot, id: \.id) { consumableViewModel in
                LootConsumableButton(
                    consumableViewModel: consumableViewModel,
                    playerViewModel: self.playerViewModel,
                    lootBagViewModel: self.lootBagViewModel,
                    pageGeometry: self.pageGeometry
                )
            }
            
            ForEach(self.lootBagViewModel.potionViewModelLoot, id: \.id) { potionViewModel in
                LootPotionButton(
                    potionViewModel: potionViewModel,
                    playerViewModel: self.playerViewModel,
                    lootBagViewModel: self.lootBagViewModel,
                    pageGeometry: self.pageGeometry
                )
            }
            
            if self.lootBagViewModel.goldLoot > 0 {
                LootGoldButton(
                    amount: self.lootBagViewModel.goldLoot,
                    playerViewModel: self.playerViewModel,
                    lootBagViewModel: self.lootBagViewModel
                )
            }
            
            YonderWideButton(text: Strings("button.finished").local) {
                self.playerViewModel.finishLooting()
            }
        }
    }
}

struct CollectLootView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            PreviewContentView {
                VStack {
                    CollectLootView(playerViewModel: PreviewObjects.playerViewModel, lootBagViewModel: PreviewObjects.lootBagViewModel, pageGeometry: geo)
                }
            }
        }
    }
}

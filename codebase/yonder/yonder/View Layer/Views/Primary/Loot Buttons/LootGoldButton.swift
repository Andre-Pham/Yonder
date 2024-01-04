//
//  LootGoldButton.swift
//  yonder
//
//  Created by Andre Pham on 17/7/2022.
//

import SwiftUI

struct LootGoldButton: View {
    let amount: Int
    @ObservedObject var playerViewModel: PlayerViewModel
    @ObservedObject var lootViewModel: LootViewModel
    
    var body: some View {
        LootButton(
            text: Strings("loot.category.gold").local.rightPadded(by: ":".continuedBy(Strings("currencySymbol").local + String(self.amount))),
            collectText: Strings("button.collect").local
        ) {
            self.lootViewModel.collectGold(playerViewModel: self.playerViewModel)
        }
    }
}

struct LootGoldButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            LootGoldButton(amount: 500, playerViewModel: PreviewObjects.playerViewModel, lootViewModel: PreviewObjects.lootBagViewModel)
        }
    }
}

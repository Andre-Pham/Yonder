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
    @ObservedObject var lootBagViewModel: LootBagViewModel
    
    var body: some View {
        LootButton(
            text: Strings.Loot.Category.Gold.local.rightPadded(by: ":".continuedBy(Strings.CurrencySymbol.local + String(self.amount))),
            collectText: Strings.Button.Collect.local
        ) {
            self.lootBagViewModel.collectGold(playerViewModel: self.playerViewModel)
        }
    }
}

struct LootGoldButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            LootGoldButton(amount: 500, playerViewModel: PreviewObjects.playerViewModel(), lootBagViewModel: PreviewObjects.lootBagViewModel)
        }
    }
}

//
//  LootPotionButton.swift
//  yonder
//
//  Created by Andre Pham on 17/7/2022.
//

import SwiftUI

struct LootPotionButton: View {
    @ObservedObject var potionViewModel: PotionViewModel
    @ObservedObject var playerViewModel: PlayerViewModel
    @ObservedObject var lootViewModel: LootViewModel
    var pageGeometry: GeometryProxy
    @State private var inspectActive = false
    
    var body: some View {
        LootButton(
            text: self.potionViewModel.name,
            collectText: Strings("button.collect").local,
            infoButton: true
        ) {
            self.lootViewModel.collectPotion(potionViewModel: self.potionViewModel, playerViewModel: self.playerViewModel)
        } onInfo: {
            self.inspectActive = true
        }
        .withInspectSheet(
            isPresented: self.$inspectActive,
            pageGeometry: self.pageGeometry,
            content: AnyView(
                ItemInspectView(itemViewModel: self.potionViewModel, playerViewModel: self.playerViewModel)
            )
        )
    }
}

struct LootPotionButton_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            PreviewContentView {
                LootPotionButton(potionViewModel: PreviewObjects.potionViewModel, playerViewModel: PreviewObjects.playerViewModel, lootViewModel: PreviewObjects.lootBagViewModel, pageGeometry: geo)
            }
        }
    }
}

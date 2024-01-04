//
//  LootConsumableButton.swift
//  yonder
//
//  Created by Andre Pham on 9/11/2022.
//

import SwiftUI

struct LootConsumableButton: View {
    @ObservedObject var consumableViewModel: ConsumableViewModel
    @ObservedObject var playerViewModel: PlayerViewModel
    @ObservedObject var lootViewModel: LootViewModel
    var pageGeometry: GeometryProxy
    @State private var inspectActive = false
    
    var body: some View {
        LootButton(
            text: self.consumableViewModel.name,
            collectText: Strings("button.collect").local,
            infoButton: true
        ) {
            self.lootViewModel.collectConsumable(consumableViewModel: self.consumableViewModel, playerViewModel: self.playerViewModel)
        } onInfo: {
            self.inspectActive = true
        }
        .withInspectSheet(
            isPresented: self.$inspectActive,
            pageGeometry: self.pageGeometry,
            content: AnyView(
                ItemInspectView(itemViewModel: self.consumableViewModel, playerViewModel: self.playerViewModel)
            )
        )
    }
}

struct LootConsumableButton_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            PreviewContentView {
                LootConsumableButton(consumableViewModel: PreviewObjects.consumableViewModel, playerViewModel: PreviewObjects.playerViewModel, lootViewModel: PreviewObjects.lootBagViewModel, pageGeometry: geo)
            }
        }
    }
}

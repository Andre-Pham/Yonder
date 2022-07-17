//
//  LootArmorButton.swift
//  yonder
//
//  Created by Andre Pham on 17/7/2022.
//

import SwiftUI

struct LootArmorButton: View {
    @ObservedObject var armorViewModel: ArmorViewModel
    @ObservedObject var playerViewModel: PlayerViewModel
    @ObservedObject var lootBagViewModel: LootBagViewModel
    var pageGeometry: GeometryProxy
    @State private var inspectActive = false
    
    var body: some View {
        LootButton(
            text: self.armorViewModel.name,
            collectText: Strings.Button.Equip.local,
            infoButton: true
        ) {
            self.lootBagViewModel.collectArmor(armorViewModel: self.armorViewModel, playerViewModel: self.playerViewModel)
        } onInfo: {
            self.inspectActive = true
        }
        .withInspectSheet(
            isPresented: self.$inspectActive,
            pageGeometry: self.pageGeometry,
            content: AnyView(
                ArmorInspectView(armorViewModel: self.armorViewModel)
            )
        )
    }
}

struct LootArmorButton_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            PreviewContentView {
                LootArmorButton(armorViewModel: PreviewObjects.armorViewModel, playerViewModel: PreviewObjects.playerViewModel(), lootBagViewModel: PreviewObjects.lootBagViewModel, pageGeometry: geo)
            }
        }
    }
}

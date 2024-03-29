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
    @ObservedObject var lootViewModel: LootViewModel
    var pageGeometry: GeometryProxy
    @State private var inspectActive = false
    @State private var equipArmorSheetActive = false
    
    var body: some View {
        LootButton(
            text: self.armorViewModel.name,
            collectText: Strings("button.equip").local,
            infoButton: true
        ) {
            self.equipArmorSheetActive = true
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
        .withInspectSheet(
            isPresented: self.$equipArmorSheetActive,
            pageGeometry: self.pageGeometry,
            content: AnyView(
                EquipArmorView(
                    playerViewModel: self.playerViewModel,
                    armorViewModel: self.armorViewModel
                ) { confirmEquip in
                    self.equipArmorSheetActive = false
                    // This is a buffer added - otherwise the sheet doesn't dismiss
                    // I presume because this function changes the content in the sheet, its dismissal doesn't trigger properly
                    // The delay isn't noticeable
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                        if confirmEquip {
                            self.lootViewModel.collectArmor(
                                armorViewModel: self.armorViewModel,
                                playerViewModel: self.playerViewModel
                            )
                        }
                    }
                }
            )
        )
    }
}

struct LootArmorButton_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            PreviewContentView {
                LootArmorButton(armorViewModel: PreviewObjects.armorViewModel, playerViewModel: PreviewObjects.playerViewModel, lootViewModel: PreviewObjects.lootBagViewModel, pageGeometry: geo)
            }
        }
    }
}

//
//  LootWeaponButton.swift
//  yonder
//
//  Created by Andre Pham on 17/7/2022.
//

import SwiftUI

struct LootWeaponButton: View {
    @ObservedObject var weaponViewModel: WeaponViewModel
    @ObservedObject var playerViewModel: PlayerViewModel
    @ObservedObject var lootViewModel: LootViewModel
    var pageGeometry: GeometryProxy
    @State private var inspectActive = false
    
    var body: some View {
        LootButton(
            text: self.weaponViewModel.name,
            collectText: Strings("button.collect").local,
            infoButton: true
        ) {
            self.lootViewModel.collectWeapon(weaponViewModel: self.weaponViewModel, playerViewModel: self.playerViewModel)
        } onInfo: {
            self.inspectActive = true
        }
        .withInspectSheet(
            isPresented: self.$inspectActive,
            pageGeometry: self.pageGeometry,
            content: AnyView(
                ItemInspectView(itemViewModel: self.weaponViewModel, playerViewModel: self.playerViewModel)
            )
        )
    }
}

struct LootWeaponButton_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            PreviewContentView {
                LootWeaponButton(weaponViewModel: PreviewObjects.weaponViewModel, playerViewModel: PreviewObjects.playerViewModel, lootViewModel: PreviewObjects.lootBagViewModel, pageGeometry: geo)
            }
        }
    }
}

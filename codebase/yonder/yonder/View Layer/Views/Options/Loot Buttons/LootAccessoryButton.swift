//
//  LootAccessoryButton.swift
//  yonder
//
//  Created by Andre Pham on 17/7/2022.
//

import SwiftUI

struct LootAccessoryButton: View {
    @ObservedObject var accessoryViewModel: AccessoryViewModel
    @ObservedObject var playerViewModel: PlayerViewModel
    @ObservedObject var lootBagViewModel: LootBagViewModel
    var pageGeometry: GeometryProxy
    @State private var inspectActive = false
    @State private var accessorySelectionSheetActive = false
    
    var body: some View {
        LootButton(
            text: self.accessoryViewModel.name,
            collectText: Strings.Button.Equip.local,
            infoButton: true
        ) {
            if self.accessoryViewModel.isPeripheral {
                self.lootBagViewModel.collectAccessory(accessoryViewModel: self.accessoryViewModel, replacing: nil, playerViewModel: self.playerViewModel)
            } else {
                self.accessorySelectionSheetActive = true
            }
        } onInfo: {
            self.inspectActive = true
        }
        .withInspectSheet(
            isPresented: self.$inspectActive,
            pageGeometry: self.pageGeometry,
            content: AnyView(
                AccessoryInspectView(accessoryViewModel: self.accessoryViewModel)
            )
        )
        .withInspectSheet(
            isPresented: self.$accessorySelectionSheetActive,
            pageGeometry: self.pageGeometry,
            content: AnyView(
                AccessorySlotSelectionInspectView(playerViewModel: self.playerViewModel) { selection in
                    self.lootBagViewModel.collectAccessory(accessoryViewModel: self.accessoryViewModel, replacing: selection, playerViewModel: self.playerViewModel)
                }
        ))
    }
}

struct LootAccessoryButton_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            PreviewContentView {
                LootAccessoryButton(accessoryViewModel: PreviewObjects.accessoryViewModel, playerViewModel: PreviewObjects.playerViewModel, lootBagViewModel: PreviewObjects.lootBagViewModel, pageGeometry: geo)
            }
        }
    }
}

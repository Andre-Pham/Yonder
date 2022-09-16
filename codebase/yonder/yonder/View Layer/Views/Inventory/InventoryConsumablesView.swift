//
//  InventoryConsumablesView.swift
//  yonder
//
//  Created by Andre Pham on 9/9/2022.
//

import SwiftUI

struct InventoryConsumablesView: View {
    @ObservedObject var sheetsStateManager: InventorySheetsStateManager
    @ObservedObject var playerViewModel: PlayerViewModel
    let pageGeometry: GeometryProxy
    
    var body: some View {
        ForEach(Array(zip(self.playerViewModel.consumableViewModels.indices, self.playerViewModel.consumableViewModels)), id: \.1.id) { index, consumableViewModel in
            YonderWideButton(text: consumableViewModel.name) {
                self.sheetsStateManager.presentConsumableSheet(at: index)
            }
            .withInspectSheet(
                isPresented: self.$sheetsStateManager.consumableSheetBindings[index],
                pageGeometry: self.pageGeometry,
                content: AnyView(
                    ItemInspectView(itemViewModel: consumableViewModel, playerViewModel: self.playerViewModel)
            ))
        }
    }
}

struct InventoryConsumablesView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContentView {
            GeometryReader { geo in
                InventoryConsumablesView(sheetsStateManager: InventorySheetsStateManager(playerViewModel: PreviewObjects.playerViewModel), playerViewModel: PreviewObjects.playerViewModel, pageGeometry: geo)
            }
        }
    }
}

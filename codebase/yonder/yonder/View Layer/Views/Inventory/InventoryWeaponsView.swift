//
//  InventoryWeaponsView.swift
//  yonder
//
//  Created by Andre Pham on 27/6/2022.
//

import SwiftUI

struct InventoryWeaponsView: View {
    @ObservedObject var sheetsStateManager: InventorySheetsStateManager
    @ObservedObject var playerViewModel: PlayerViewModel
    let pageGeometry: GeometryProxy
    
    var body: some View {
        ForEach(Array(zip(self.playerViewModel.weaponViewModels.indices, self.playerViewModel.weaponViewModels)), id: \.1.id) { index, weaponViewModel in
            YonderWideButton(text: weaponViewModel.name) {
                self.sheetsStateManager.presentWeaponSheet(at: index)
            }
            .withInspectSheet(
                isPresented: self.$sheetsStateManager.weaponSheetBindings[index],
                pageGeometry: self.pageGeometry,
                content: AnyView(
                    ItemInspectView(itemViewModel: weaponViewModel, playerViewModel: self.playerViewModel)
            ))
        }
    }
}

struct InventoryWeaponsView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            ZStack {
                YonderColors.backgroundMaxDepth
                    .ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    InventoryWeaponsView(sheetsStateManager: InventorySheetsStateManager(playerViewModel: PreviewObjects.playerViewModel()), playerViewModel: PreviewObjects.playerViewModel(), pageGeometry: geo)
                }
            }
        }
    }
}

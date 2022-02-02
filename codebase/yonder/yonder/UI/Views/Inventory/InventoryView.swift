//
//  InventoryView.swift
//  yonder
//
//  Created by Andre Pham on 10/12/21.
//

import SwiftUI

struct InventoryView: View {
    @ObservedObject private var playerViewModel: PlayerViewModel
    @ObservedObject private var sheetsStateManager: InventorySheetsStateManager
    
    init() {
        let playerViewModel = PlayerViewModel(GAME.player)
        
        self.playerViewModel = playerViewModel
        self.sheetsStateManager = InventorySheetsStateManager(playerViewModel: playerViewModel)
    }
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                // ForEach(Array(zip(previousIDs, previousCoordinates)), id: \.0) { id, coords in
                VStack(spacing: YonderCoreGraphics.padding) {
                    ForEach(Array(zip(playerViewModel.weaponViewModels.indices, playerViewModel.weaponViewModels)), id: \.1.id) { index, weaponViewModel in
                        Button {
                            self.sheetsStateManager.presentWeaponSheet(at: index)
                        } label: {
                            YonderRectButtonLabel(text: weaponViewModel.name)
                        }
                        .sheet(isPresented: self.$sheetsStateManager.weaponSheetBindings[index]) {
                            Text("Wow! \(index)")
                        }
                    }
                }
            }
        }
    }
}

struct InventoryView_Previews: PreviewProvider {
    static var previews: some View {
        InventoryView()
    }
}

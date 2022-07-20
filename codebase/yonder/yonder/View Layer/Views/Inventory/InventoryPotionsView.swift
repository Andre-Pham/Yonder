//
//  InventoryPotionsView.swift
//  yonder
//
//  Created by Andre Pham on 27/6/2022.
//

import SwiftUI

struct InventoryPotionsView: View {
    @ObservedObject var sheetsStateManager: InventorySheetsStateManager
    @ObservedObject var playerViewModel: PlayerViewModel
    let pageGeometry: GeometryProxy
    
    var body: some View {
        ForEach(Array(zip(self.playerViewModel.potionViewModels.indices, self.playerViewModel.potionViewModels)), id: \.1.id) { index, potionViewModel in
            YonderWideButton(text: potionViewModel.name) {
                self.sheetsStateManager.presentPotionSheet(at: index)
            }
            .withInspectSheet(
                isPresented: self.$sheetsStateManager.potionSheetBindings[index],
                pageGeometry: self.pageGeometry,
                content: AnyView(
                    ItemInspectView(itemViewModel: potionViewModel, playerViewModel: self.playerViewModel)
            ))
        }
    }
}

struct InventoryPotionsView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            ZStack {
                YonderColors.backgroundMaxDepth
                    .ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    InventoryPotionsView(sheetsStateManager: InventorySheetsStateManager(playerViewModel: PreviewObjects.playerViewModel), playerViewModel: PreviewObjects.playerViewModel, pageGeometry: geo)
                }
            }
        }
    }
}

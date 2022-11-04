//
//  InventoryAccessoriesView.swift
//  yonder
//
//  Created by Andre Pham on 9/7/2022.
//

import SwiftUI

struct InventoryAccessoriesView: View {
    @ObservedObject var sheetsStateManager: InventorySheetsStateManager
    @ObservedObject var playerViewModel: PlayerViewModel
    let pageGeometry: GeometryProxy
    
    var body: some View {
        if self.playerViewModel.accessoryViewModels.count == 0 {
            SurroundingBrackets(bracket: "[", size: .title4) {
                YonderText(text: Strings("inventory.accessories.headerZeroAccessories").local, size: .title4)
            }
        }
        
        ForEach(Array(zip(self.playerViewModel.accessoryViewModels.indices, self.playerViewModel.accessoryViewModels)), id: \.1.id) { index, accessoryViewModel in
            YonderWideButtonBody {
                self.sheetsStateManager.presentAccessorySheet(at: index)
            } label: {
                HStack(alignment: .firstTextBaseline, spacing: 0) {
                    YonderText(text: Strings("inventory.accessories.slot").local.continuedBy("\(index+1): "), size: .buttonBodySubscript)
                        .padding(.leading)
                    
                    YonderText(text: accessoryViewModel.name, size: .buttonBody)
                    
                    Spacer()
                }
            }
            .withInspectSheet(
                isPresented: self.$sheetsStateManager.accessorySheetBindings[index],
                pageGeometry: self.pageGeometry,
                content: AnyView(
                    AccessoryInspectView(accessoryViewModel: accessoryViewModel)
            ))
        }
        
        if !self.playerViewModel.accessorySlotsFull && playerViewModel.accessoryViewModels.count != 0 {
            SurroundingBrackets(bracket: "[", size: .title4) {
                YonderText(text: "+\(self.playerViewModel.emptyAccessorySlotsCount)".continuedBy(Strings("inventory.accessories.emptySlots").local), size: .title4)
            }
        }
    }
}

struct InventoryAccessoriesView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            ZStack {
                YonderColors.backgroundMaxDepth
                    .ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    InventoryAccessoriesView(sheetsStateManager: InventorySheetsStateManager(playerViewModel: PreviewObjects.playerViewModel), playerViewModel: PreviewObjects.playerViewModel, pageGeometry: geo)
                }
            }
        }
    }
}

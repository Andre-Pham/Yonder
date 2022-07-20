//
//  InventoryArmorView.swift
//  yonder
//
//  Created by Andre Pham on 9/7/2022.
//

import SwiftUI

struct InventoryArmorView: View {
    @ObservedObject var sheetsStateManager: InventorySheetsStateManager
    @ObservedObject var playerViewModel: PlayerViewModel
    let pageGeometry: GeometryProxy
    
    var body: some View {
        ForEach(Array(zip(0..<self.playerViewModel.allArmorViewModels.count, self.playerViewModel.allArmorViewModels)), id: \.1.id) { index, armorViewModel in
            YonderWideButtonBody {
                self.sheetsStateManager.presentArmorSheet(at: index)
            } label: {
                HStack(alignment: .firstTextBaseline, spacing: 0) {
                    YonderText(text: "\(armorViewModel.type.name): ", size: .buttonBodySubscript)
                        .padding(.leading)
                    
                    YonderText(text: armorViewModel.name, size: .buttonBody)
                    
                    Spacer()
                }
            }
            .withInspectSheet(
                isPresented: self.$sheetsStateManager.armorSheetBindings[index],
                pageGeometry: pageGeometry,
                content: AnyView(
                    ArmorInspectView(armorViewModel: armorViewModel)
                ))
        }
    }
}

struct InventoryArmorView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            ZStack {
                YonderColors.backgroundMaxDepth
                    .ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    InventoryArmorView(sheetsStateManager: InventorySheetsStateManager(playerViewModel: PreviewObjects.playerViewModel), playerViewModel: PreviewObjects.playerViewModel, pageGeometry: geo)
                }
            }
        }
    }
}

//
//  InventoryView.swift
//  yonder
//
//  Created by Andre Pham on 10/12/21.
//

import SwiftUI

struct InventoryView: View {
    @StateObject private var playerViewModel = gameManager.playerVM
    @StateObject private var sheetsStateManager = InventorySheetsStateManager(playerViewModel: gameManager.playerVM)
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack(alignment: .leading, spacing: YonderCoreGraphics.padding) {
                    YonderText(text: Term.armor.capitalized, size: .title2)
                    
                    ForEach(self.playerViewModel.allArmorViewModels, id: \.id) { armorViewModel in
                        YonderWideButtonBody {
                            // Code
                        } label: {
                            HStack(alignment: .lastTextBaseline, spacing: 0) {
                                YonderText(text: "\(Term.armorSlot(of: armorViewModel.type).capitalized): ", size: .buttonBodySubscript)
                                    .padding(.leading)
                                
                                YonderText(text: armorViewModel.name, size: .buttonBody)
                                
                                Spacer()
                            }
                        }
                    }
                    
                    YonderText(text: Term.inventory.capitalized, size: .title2)
                    // Buttons to show weapons, potions
                    
                    // Armor
                    // Accessories (in the future)
                    // Weapons/Potions buttons
                    
                    ForEach(Array(zip(playerViewModel.weaponViewModels.indices, playerViewModel.weaponViewModels)), id: \.1.id) { index, weaponViewModel in
                        YonderButton(text: weaponViewModel.name) {
                            self.sheetsStateManager.presentWeaponSheet(at: index)
                        }
                        .withInspectSheet(isPresented: self.$sheetsStateManager.weaponSheetBindings[index], pageGeometry: geo, content: AnyView(
                            ItemInspectView(itemViewModel: weaponViewModel)
                        ))
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct InventoryView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Yonder.backgroundMaxDepth
                .ignoresSafeArea()
            
            InventoryView()
        }
    }
}

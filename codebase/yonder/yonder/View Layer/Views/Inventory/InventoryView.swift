//
//  InventoryView.swift
//  yonder
//
//  Created by Andre Pham on 10/12/21.
//

import SwiftUI

struct InventoryView: View {
    @StateObject private var playerViewModel = GameManager.instance.playerVM
    @StateObject private var sheetsStateManager = InventorySheetsStateManager(playerViewModel: GameManager.instance.playerVM)
    @StateObject private var inventoryStateManager = InventoryStateManager()
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack(alignment: .leading, spacing: YonderCoreGraphics.padding) {
                    YonderText(text: Strings.Inventory.Title.Armor.local, size: .title2)
                    
                    ForEach(Array(zip(0..<self.playerViewModel.allArmorViewModels.count, self.playerViewModel.allArmorViewModels)), id: \.1.id) { index, armorViewModel in
                        YonderWideButtonBody {
                            self.sheetsStateManager.presentArmorSheet(at: index)
                        } label: {
                            HStack(alignment: .lastTextBaseline, spacing: 0) {
                                YonderText(text: "\(armorViewModel.type.name): ", size: .buttonBodySubscript)
                                    .padding(.leading)
                                
                                YonderText(text: armorViewModel.name, size: .buttonBody)
                                
                                Spacer()
                            }
                        }
                        .withInspectSheet(
                            isPresented: self.$sheetsStateManager.armorSheetBindings[index],
                            pageGeometry: geo,
                            content: AnyView(
                                ArmorInspectView(armorViewModel: armorViewModel)
                            ))
                    }
                    
                    YonderText(text: Strings.Inventory.Title.Accessories.local, size: .title2)
                    
                    // TODO: Implement after accessories are added
                    
                    YonderText(text: Strings.Inventory.Title.Items.local, size: .title2)
                    
                    YonderOptionsGrid {
                        YonderGridOption(title: Strings.Inventory.Weapons.Option.local, geometry: geo, image: YonderImages.weaponOptionIcon) {
                            self.inventoryStateManager.weaponOptionSelected(weaponCount: self.playerViewModel.weaponViewModels.count)
                        }
                        
                        YonderGridOption(title: Strings.Inventory.Potions.Option.local, geometry: geo, image: YonderImages.potionOptionIcon) {
                            self.inventoryStateManager.potionOptionSelected(potionCount: self.playerViewModel.potionViewModels.count)
                        }
                    }
                    
                    if let header = self.inventoryStateManager.optionHeader {
                        YonderText(text: header, size: .title4)
                            .frame(maxWidth: .infinity)
                    }
                    
                    if self.inventoryStateManager.weaponsActive {
                        InventoryWeaponsView(sheetsStateManager: self.sheetsStateManager, playerViewModel: self.playerViewModel, pageGeometry: geo)
                    }
                    
                    if self.inventoryStateManager.potionsActive {
                        InventoryPotionsView(sheetsStateManager: self.sheetsStateManager, playerViewModel: self.playerViewModel, pageGeometry: geo)
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
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            InventoryView()
        }
    }
}

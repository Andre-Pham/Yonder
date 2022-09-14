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
                    // Armor
                    Group {
                        YonderText(text: Strings.Inventory.Title.Armor.local, size: .title2)
                        
                        InventoryArmorView(sheetsStateManager: self.sheetsStateManager, playerViewModel: self.playerViewModel, pageGeometry: geo)
                    }
                    
                    // Accessories
                    Group {
                        YonderText(text: Strings.Inventory.Title.Accessories.local, size: .title2)
                        
                        InventoryAccessoriesView(sheetsStateManager: self.sheetsStateManager, playerViewModel: self.playerViewModel, pageGeometry: geo)
                    }
                    
                    // Peripheral Accessory
                    Group {
                        YonderText(text: Strings.Inventory.Title.PeripheralAccessory.local, size: .title2)
                        
                        YonderWideButton(text: self.playerViewModel.peripheralAccessoryViewModel.name) {
                            self.sheetsStateManager.peripheralAccessorySheetBinding = true
                        }
                        .withInspectSheet(
                            isPresented: self.$sheetsStateManager.peripheralAccessorySheetBinding,
                            pageGeometry: geo,
                            content: AnyView(
                                AccessoryInspectView(accessoryViewModel: self.playerViewModel.peripheralAccessoryViewModel)
                            ))
                    }
                    
                    // Items
                    Group {
                        YonderText(text: Strings.Inventory.Title.Items.local, size: .title2)
                        
                        YonderOptionsGrid {
                            YonderGridOption(title: Strings.Inventory.Weapons.Option.local, geometry: geo, image: YonderImages.weaponOptionIcon) {
                                self.inventoryStateManager.weaponOptionSelected(weaponCount: self.playerViewModel.weaponViewModels.count)
                            }
                            
                            YonderGridOption(title: Strings.Inventory.Potions.Option.local, geometry: geo, image: YonderImages.potionOptionIcon) {
                                self.inventoryStateManager.potionOptionSelected(potionCount: self.playerViewModel.potionViewModels.count)
                            }
                            
                            YonderGridOption(title: Strings.Inventory.Consumables.Option.local, geometry: geo, image: YonderImages.consumableOptionIcon) {
                                self.inventoryStateManager.consumableOptionSelected(consumableCount: self.playerViewModel.consumableViewModels.count)
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
                        
                        if self.inventoryStateManager.consumablesActive {
                            InventoryConsumablesView(sheetsStateManager: self.sheetsStateManager, playerViewModel: self.playerViewModel, pageGeometry: geo)
                        }
                    }
                }
                .padding(.horizontal)
                // Extended scrolling without needing content to scroll to
                .padding(.bottom, geo.size.height/2)
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

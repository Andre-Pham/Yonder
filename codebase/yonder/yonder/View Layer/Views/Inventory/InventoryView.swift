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
                    YonderText(text: Term.armor.capitalized, size: .title2)
                    
                    ForEach(Array(zip(0..<self.playerViewModel.allArmorViewModels.count, self.playerViewModel.allArmorViewModels)), id: \.1.id) { index, armorViewModel in
                        YonderWideButtonBody {
                            self.sheetsStateManager.presentArmorSheet(at: index)
                        } label: {
                            HStack(alignment: .lastTextBaseline, spacing: 0) {
                                YonderText(text: "\(Term.armorSlot(of: armorViewModel.type).capitalized): ", size: .buttonBodySubscript)
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
                    
                    YonderText(text: Term.accessories.capitalized, size: .title2)
                    
                    // TODO: Implement after accessories are added
                    
                    YonderText(text: Term.inventory.capitalized, size: .title2)
                    
                    YonderOptionsGrid {
                        YonderGridOption(title: Term.weapons.capitalized, geometry: geo, image: YonderImages.weaponOptionIcon) {
                            self.inventoryStateManager.weaponOptionSelected(weaponCount: self.playerViewModel.weaponViewModels.count)
                        }
                        
                        YonderGridOption(title: Term.potions.capitalized, geometry: geo, image: YonderImages.potionOptionIcon) {
                            self.inventoryStateManager.potionOptionSelected(potionCount: self.playerViewModel.potionViewModels.count)
                        }
                    }
                    
                    if let header = self.inventoryStateManager.optionHeader {
                        YonderText(text: header, size: .title4)
                            .frame(maxWidth: .infinity)
                    }
                    
                    if self.inventoryStateManager.weaponsActive {
                        ForEach(Array(zip(playerViewModel.weaponViewModels.indices, playerViewModel.weaponViewModels)), id: \.1.id) { index, weaponViewModel in
                            YonderWideButton(text: weaponViewModel.name) {
                                self.sheetsStateManager.presentWeaponSheet(at: index)
                            }
                            .withInspectSheet(
                                isPresented: self.$sheetsStateManager.weaponSheetBindings[index],
                                pageGeometry: geo,
                                content: AnyView(
                                ItemInspectView(itemViewModel: weaponViewModel)
                            ))
                        }
                    }
                    
                    if self.inventoryStateManager.potionsActive {
                        ForEach(Array(zip(playerViewModel.potionViewModels.indices, playerViewModel.potionViewModels)), id: \.1.id) { index, potionViewModel in
                            YonderWideButton(text: potionViewModel.name) {
                                self.sheetsStateManager.presentPotionSheet(at: index)
                            }
                            .withInspectSheet(
                                isPresented: self.$sheetsStateManager.potionSheetBindings[index],
                                pageGeometry: geo,
                                content: AnyView(
                                ItemInspectView(itemViewModel: potionViewModel)
                            ))
                        }
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

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
                VStack(alignment: .leading, spacing: YonderCoreGraphics.padding) {
                    YonderText(text: Term.stats.capitalized, size: .title2)
                    
                    VStack(alignment: .leading, spacing: 6) {
                        StatView(title: Term.armorPoints.capitalized, value: "\(self.playerViewModel.armorPoints)", maxValue: "\(self.playerViewModel.maxArmorPoints)", image: YonderImages.shieldIcon)
                        
                        StatView(title: Term.health.capitalized, value: "\(self.playerViewModel.health)", maxValue: "\(self.playerViewModel.maxHealth)", image: YonderImages.healthIcon)
                        
                        StatView(title: Term.gold.capitalized, value: "\(Term.currencySymbol)\(self.playerViewModel.gold)", image: YonderImages.goldIcon)
                    }
                    
                    YonderText(text: Term.armor.capitalized, size: .title2)
                    
                    ForEach(self.playerViewModel.allArmorViewModels, id: \.id) { armorViewModel in
                        YonderWideButtonBody {
                            // Code
                        } label: {
                            HStack(alignment: .lastTextBaseline, spacing: 0) {
                                YonderText(text: "\(Term.armorSlot(of: armorViewModel.type).capitalized): ", size: .buttonBodySubscript)
                                    .padding(.leading)
                                
                                YonderText(text: "\(armorViewModel.name)", size: .buttonBody)
                                
                                Spacer()
                            }
                        }
                    }
                    
                    YonderText(text: Term.buffsAndEffects.capitalized, size: .title2)
                    
                    YonderText(text: Term.inventory.capitalized, size: .title2)
                    // Buttons to show weapons, potions
                    
                    // Armor
                    // Accessories (in the future)
                    // Weapons/Potions buttons
                    
                    VStack(spacing: YonderCoreGraphics.padding) {
                        ForEach(Array(zip(playerViewModel.weaponViewModels.indices, playerViewModel.weaponViewModels)), id: \.1.id) { index, weaponViewModel in
                            YonderButton(text: weaponViewModel.name) {
                                self.sheetsStateManager.presentWeaponSheet(at: index)
                            }
                            .sheet(isPresented: self.$sheetsStateManager.weaponSheetBindings[index]) {
                                Text("Wow! \(index)")
                            }
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
            Color.Yonder.backgroundMaxDepth
                .ignoresSafeArea()
            
            InventoryView()
        }
    }
}

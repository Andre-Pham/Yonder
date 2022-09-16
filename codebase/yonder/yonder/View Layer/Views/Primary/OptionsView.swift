//
//  OptionsView.swift
//  yonder
//
//  Created by Andre Pham on 23/7/2022.
//

import SwiftUI

struct OptionsView: View {
    @EnvironmentObject private var viewRouter: ViewRouter
    @EnvironmentObject private var travelStateManager: TravelStateManager
    @ObservedObject var playerViewModel: PlayerViewModel
    @ObservedObject var optionsStateManager: OptionsStateManager
    let pageGeometry: GeometryProxy
    
    var body: some View {
        YonderOptionsGrid {
            if optionsStateManager.weaponOptionActive {
                YonderGridOption(title: Strings.OptionsMenu.Option.Weapon.local, geometry: self.pageGeometry, image: YonderImages.weaponOptionIcon) {
                    self.optionsStateManager.weaponOptionSelected()
                }
            }
            
            if optionsStateManager.potionOptionActive {
                YonderGridOption(title: Strings.OptionsMenu.Option.Potion.local, geometry: self.pageGeometry, image: YonderImages.potionOptionIcon) {
                    self.optionsStateManager.potionOptionSelected()
                }
            }
            
            if self.optionsStateManager.offerOptionActive {
                YonderGridOption(title: Strings.OptionsMenu.Option.Offer.local, geometry: self.pageGeometry, image: self.playerViewModel.locationViewModel.getTypeImage()) {
                    self.optionsStateManager.offerOptionSelected()
                }
            }
            
            if self.optionsStateManager.purchaseRestorationOptionActive {
                YonderGridOption(title: Strings.OptionsMenu.Option.Restoration.local, geometry: self.pageGeometry, image: self.playerViewModel.locationViewModel.getTypeImage()) {
                    self.optionsStateManager.purchaseRestorationOptionSelected()
                }
            }
            
            if self.optionsStateManager.shopOptionActive {
                YonderGridOption(title: Strings.OptionsMenu.Option.Shop.local, geometry: self.pageGeometry, image: self.playerViewModel.locationViewModel.getTypeImage()) {
                    self.optionsStateManager.shopOptionSelected()
                }
            }
            
            if self.optionsStateManager.enhanceOptionActive {
                YonderGridOption(title: Strings.OptionsMenu.Option.Enhance.local, geometry: self.pageGeometry, image: self.playerViewModel.locationViewModel.getTypeImage()) {
                    self.optionsStateManager.enhanceOptionSelected()
                }
            }
            
            if self.optionsStateManager.chooseLootBagOptionActive {
                YonderGridOption(
                    title: Strings.OptionsMenu.Option.ChooseLootBag.local,
                    geometry: self.pageGeometry,
                    image: YonderImages.chooseLootBagOptionIcon
                ) {
                    self.optionsStateManager.chooseLootBagOptionSelected()
                }
            }
            
            if self.optionsStateManager.lootOptionActive {
                YonderGridOption(
                    title: Strings.OptionsMenu.Option.Loot.local,
                    geometry: self.pageGeometry,
                    image: YonderImages.lootOptionIcon
                ) {
                    self.optionsStateManager.lootOptionSelected()
                }
            }
            
            if self.optionsStateManager.travelOptionActive {
                YonderGridOption(title: Strings.OptionsMenu.Option.Travel.local, geometry: self.pageGeometry, image: YonderImages.mapIcon) {
                    self.optionsStateManager.travelOptionSelected(
                        viewRouter: self.viewRouter,
                        travelStateManager: self.travelStateManager)
                }
            }
            
            if optionsStateManager.consumableOptionActive {
                YonderGridOption(title: Strings.OptionsMenu.Option.Consumable.local, geometry: self.pageGeometry, image: YonderImages.consumableOptionIcon) {
                    self.optionsStateManager.consumableOptionSelected()
                }
            }
        }
    }
}

struct OptionsView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContentView {
            GeometryReader { geo in
                OptionsView(
                    playerViewModel: PreviewObjects.playerViewModel,
                    optionsStateManager: OptionsStateManager(playerViewModel: PreviewObjects.playerViewModel),
                    pageGeometry: geo
                )
            }
        }
    }
}

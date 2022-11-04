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
                YonderGridOption(title: Strings("optionsMenu.option.weapon").local, geometry: self.pageGeometry, image: YonderImages.weaponOptionIcon) {
                    self.optionsStateManager.weaponOptionSelected()
                }
            }
            
            if optionsStateManager.potionOptionActive {
                YonderGridOption(title: Strings("optionsMenu.option.potion").local, geometry: self.pageGeometry, image: YonderImages.potionOptionIcon) {
                    self.optionsStateManager.potionOptionSelected()
                }
            }
            
            if self.optionsStateManager.offerOptionActive {
                YonderGridOption(title: Strings("optionsMenu.option.offer").local, geometry: self.pageGeometry, image: self.playerViewModel.locationViewModel.getTypeImage()) {
                    self.optionsStateManager.offerOptionSelected()
                }
            }
            
            if self.optionsStateManager.purchaseRestorationOptionActive {
                YonderGridOption(title: Strings("optionsMenu.option.restoration").local, geometry: self.pageGeometry, image: self.playerViewModel.locationViewModel.getTypeImage()) {
                    self.optionsStateManager.purchaseRestorationOptionSelected()
                }
            }
            
            if self.optionsStateManager.shopOptionActive {
                YonderGridOption(title: Strings("optionsMenu.option.shop").local, geometry: self.pageGeometry, image: self.playerViewModel.locationViewModel.getTypeImage()) {
                    self.optionsStateManager.shopOptionSelected()
                }
            }
            
            if self.optionsStateManager.enhanceOptionActive {
                YonderGridOption(title: Strings("optionsMenu.option.enhance").local, geometry: self.pageGeometry, image: self.playerViewModel.locationViewModel.getTypeImage()) {
                    self.optionsStateManager.enhanceOptionSelected()
                }
            }
            
            if self.optionsStateManager.chooseLootBagOptionActive {
                YonderGridOption(
                    title: Strings("optionsMenu.option.chooseLootBag").local,
                    geometry: self.pageGeometry,
                    image: YonderImages.chooseLootBagOptionIcon
                ) {
                    self.optionsStateManager.chooseLootBagOptionSelected()
                }
            }
            
            if self.optionsStateManager.lootOptionActive {
                YonderGridOption(
                    title: Strings("optionsMenu.option.loot").local,
                    geometry: self.pageGeometry,
                    image: YonderImages.lootOptionIcon
                ) {
                    self.optionsStateManager.lootOptionSelected()
                }
            }
            
            if self.optionsStateManager.travelOptionActive {
                YonderGridOption(title: Strings("optionsMenu.option.travel").local, geometry: self.pageGeometry, image: YonderImages.mapIcon) {
                    self.optionsStateManager.travelOptionSelected(
                        viewRouter: self.viewRouter,
                        travelStateManager: self.travelStateManager)
                }
            }
            
            if optionsStateManager.consumableOptionActive {
                YonderGridOption(title: Strings("optionsMenu.option.consumable").local, geometry: self.pageGeometry, image: YonderImages.consumableOptionIcon) {
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

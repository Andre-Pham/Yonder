//
//  OptionsView.swift
//  yonder
//
//  Created by Andre Pham on 10/12/21.
//

import SwiftUI

struct OptionsView: View {
    @EnvironmentObject private var viewRouter: ViewRouter
    @EnvironmentObject private var travelStateManager: TravelStateManager
    @ObservedObject private var playerViewModel: PlayerViewModel
    @ObservedObject private var optionsStateManager: OptionsStateManager
    @StateObject private var optionsSheetsStateManager = OptionsSheetsStateManager()
    
    init() {
        let playerViewModel = gameManager.playerVM
        
        self.playerViewModel = playerViewModel
        self.optionsStateManager = OptionsStateManager(playerViewModel: playerViewModel)
    }
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack(spacing: YonderCoreGraphics.padding) {
                    LocationView(locationViewModel: self.playerViewModel.locationViewModel)
                    
                    HStack(spacing: YonderCoreGraphics.padding) {
                        PlayerCardButton(
                            playerViewModel:
                                self.playerViewModel,
                            optionsSheetsStateManager:
                                self.optionsSheetsStateManager, pageGeometry: geo)
                        
                        NPCCardButton(
                            locationViewModel:
                                self.playerViewModel.locationViewModel,
                            optionsSheetsStateManager:
                                self.optionsSheetsStateManager,
                            pageGeometry: geo)
                        
                    }
                    .padding(.leading, YonderCoreGraphics.padding)
                    .padding(.trailing, YonderCoreGraphics.padding)
                    .frame(maxWidth: .infinity)
                    .frame(height: geo.size.width/2 - YonderCoreGraphics.padding*1.5)
                    
                    YonderText(text: self.optionsStateManager.optionHeader, size: .title4)
                    
                    if self.optionsStateManager.showOptions {
                        YonderOptionsGrid {
                            if optionsStateManager.weaponOptionActive {
                                YonderGridOption(title: "Select \(Term.weapon.capitalized)", geometry: geo, image: YonderImages.weaponOptionIcon) {
                                    self.optionsStateManager.weaponOptionSelected()
                                }
                            }
                            
                            if optionsStateManager.potionOptionActive {
                                YonderGridOption(title: "Select \(Term.potion.capitalized)", geometry: geo, image: YonderImages.potionOptionIcon) {
                                    self.optionsStateManager.potionOptionSelected()
                                }
                            }
                            
                            if self.optionsStateManager.offerOptionActive {
                                YonderGridOption(title: "View \(Term.offers.capitalized)", geometry: geo, image: self.playerViewModel.locationViewModel.getTypeImage()) {
                                    self.optionsStateManager.offerOptionSelected()
                                }
                            }
                            
                            if self.optionsStateManager.purchaseRestorationOptionActive {
                                YonderGridOption(title: "Purchase \(Term.restoration.capitalized)", geometry: geo, image: self.playerViewModel.locationViewModel.getTypeImage()) {
                                    self.optionsStateManager.purchaseRestorationOptionSelected()
                                }
                            }
                            
                            if self.optionsStateManager.shopOptionActive {
                                YonderGridOption(title: Term.shop.capitalized, geometry: geo, image: self.playerViewModel.locationViewModel.getTypeImage()) {
                                    self.optionsStateManager.shopOptionSelected()
                                }
                            }
                            
                            if self.optionsStateManager.enhanceOptionActive {
                                YonderGridOption(title: Term.enhance.capitalized, geometry: geo, image: self.playerViewModel.locationViewModel.getTypeImage()) {
                                    self.optionsStateManager.enhanceOptionSelected()
                                }
                            }
                            
                            if self.optionsStateManager.travelOptionActive {
                                YonderGridOption(title: Term.travel.capitalized, geometry: geo, image: YonderImages.mapIcon) {
                                    self.optionsStateManager.travelOptionSelected(
                                        viewRouter: self.viewRouter,
                                        travelStateManager: self.travelStateManager)
                                }
                            }
                        }
                        .padding(.leading, YonderCoreGraphics.padding)
                        .padding(.trailing, YonderCoreGraphics.padding)
                    }
                    
                    if self.optionsStateManager.activeActions.isActive {
                        VStack {
                            YonderWideButton(text: "Back") {
                                self.optionsStateManager.closeActions()
                            }
                            
                            if self.optionsStateManager.weaponActionsActive.isActive {
                                ForEach(self.playerViewModel.weaponViewModels, id: \.id) { weaponViewModel in
                                    UseWeaponButton(
                                        playerViewModel: self.playerViewModel,
                                        weaponViewModel: weaponViewModel)
                                }
                            }
                            
                            if self.optionsStateManager.potionActionsActive.isActive {
                                ForEach(self.playerViewModel.potionViewModels, id: \.id) { potionViewModel in
                                    UsePotionButton(
                                        playerViewModel: self.playerViewModel,
                                        potionViewModel: potionViewModel)
                                }
                            }
                            
                            if self.optionsStateManager.offerActionsActive.isActive {
                                if let friendlyViewModel = self.playerViewModel.locationViewModel.getInteractorViewModel() as? FriendlyViewModel {
                                    ForEach(friendlyViewModel.offers, id: \.id) { offer in
                                        YonderMultilineWideButton(text: [offer.name, offer.description]) {
                                            friendlyViewModel.acceptOffer(offer, player: self.playerViewModel)
                                        }
                                    }
                                }
                            }
                            
                            if self.optionsStateManager.purchaseRestorationActionsActive.isActive {
                                if let restorerViewModel = self.playerViewModel.locationViewModel.getInteractorViewModel() as? RestorerViewModel {
                                    ForEach(restorerViewModel.options, id: \.id) { option in
                                        PurchaseRestorationButton(playerViewModel: self.playerViewModel, restorationOptionViewModel: option)
                                    }
                                }
                            }
                            
                            if self.optionsStateManager.shopActionsActive.isActive {
                                if let shopKeeperViewModel = self.playerViewModel.locationViewModel.getInteractorViewModel() as? ShopKeeperViewModel {
                                    ForEach(shopKeeperViewModel.purchasables, id: \.id) { purchasable in
                                        PurchaseFromShopKeeperButton(playerViewModel: self.playerViewModel, purchasableViewModel: purchasable, pageGeometry: geo)
                                    }
                                }
                            }
                            
                            if self.optionsStateManager.enhanceActionsActive.isActive {
                                if let enhancerViewModel = self.playerViewModel.locationViewModel.getInteractorViewModel() as? EnhancerViewModel {
                                    ForEach(enhancerViewModel.enhanceOfferViewModels, id: \.id) { offer in
                                        ViewEnhanceablesButton(playerViewModel: self.playerViewModel, enhanceOfferViewModel: offer, pageGeometry: geo)
                                    }
                                }
                            }
                        }
                        .padding(.leading, YonderCoreGraphics.padding)
                        .padding(.trailing, YonderCoreGraphics.padding)
                    }
                }
            }
        }
    }
}

struct OptionsView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            OptionsView()
        }
    }
}

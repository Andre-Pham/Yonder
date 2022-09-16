//
//  ActionsView.swift
//  yonder
//
//  Created by Andre Pham on 23/7/2022.
//

import SwiftUI

struct ActionsView: View {
    @ObservedObject var playerViewModel: PlayerViewModel
    @ObservedObject var optionsStateManager: OptionsStateManager
    let pageGeometry: GeometryProxy
    
    var body: some View {
        Group {
            YonderWideButton(text: Strings.Button.Back.local) {
                self.optionsStateManager.closeActions()
            }
            
            if self.optionsStateManager.weaponActionsActive {
                ForEach(self.playerViewModel.applicableWeaponViewModels, id: \.id) { weaponViewModel in
                    UseWeaponButton(
                        playerViewModel: self.playerViewModel,
                        weaponViewModel: weaponViewModel)
                }
            }
            
            if self.optionsStateManager.potionActionsActive {
                ForEach(self.playerViewModel.potionViewModels, id: \.id) { potionViewModel in
                    UsePotionButton(
                        playerViewModel: self.playerViewModel,
                        potionViewModel: potionViewModel)
                }
            }
            
            if self.optionsStateManager.consumableActionsActive {
                ForEach(self.playerViewModel.consumableViewModels, id: \.id) { consumableViewModel in
                    UseConsumableButton(playerViewModel: self.playerViewModel, consumableViewModel: consumableViewModel)
                }
            }
            
            if self.optionsStateManager.offerActionsActive {
                if let friendlyViewModel = self.playerViewModel.locationViewModel.getInteractorViewModel() as? FriendlyViewModel {
                    ForEach(friendlyViewModel.offers, id: \.id) { offer in
                        YonderMultilineWideButton(text: [offer.name, offer.description]) {
                            friendlyViewModel.acceptOffer(offer, player: self.playerViewModel)
                        }
                        .disabledWhen(!offer.canBeAccepted(playerViewModel: self.playerViewModel))
                    }
                }
            }
            
            if self.optionsStateManager.purchaseRestorationActionsActive {
                if let restorerViewModel = self.playerViewModel.locationViewModel.getInteractorViewModel() as? RestorerViewModel {
                    ForEach(restorerViewModel.options, id: \.id) { option in
                        PurchaseRestorationButton(playerViewModel: self.playerViewModel, restorationOptionViewModel: option)
                    }
                }
            }
            
            if self.optionsStateManager.shopActionsActive {
                if let shopKeeperViewModel = self.playerViewModel.locationViewModel.getInteractorViewModel() as? ShopKeeperViewModel {
                    ForEach(shopKeeperViewModel.purchasables, id: \.id) { purchasable in
                        PurchaseFromShopKeeperButton(playerViewModel: self.playerViewModel, purchasableViewModel: purchasable, pageGeometry: self.pageGeometry)
                    }
                }
            }
            
            if self.optionsStateManager.enhanceActionsActive {
                if let enhancerViewModel = self.playerViewModel.locationViewModel.getInteractorViewModel() as? EnhancerViewModel {
                    ForEach(enhancerViewModel.enhanceOfferViewModels, id: \.id) { offer in
                        ViewEnhanceablesButton(playerViewModel: self.playerViewModel, enhanceOfferViewModel: offer, pageGeometry: self.pageGeometry)
                    }
                }
            }
            
            if self.optionsStateManager.chooseLootBagActionsActive {
                if let foeViewModel = self.playerViewModel.locationViewModel.getFoeViewModel() {
                    ForEach(foeViewModel.lootOptionsViewModel.lootBagViewModels, id: \.id) { lootBagViewModel in
                        LootBagButton(
                            playerViewModel: self.playerViewModel,
                            lootOptionsViewModel: foeViewModel.lootOptionsViewModel,
                            lootBagViewModel: lootBagViewModel)
                    }
                }
            }
            
            if self.optionsStateManager.lootActionsActive {
                if let lootBagViewModel = self.playerViewModel.lootBagViewModel {
                    CollectLootView(
                        playerViewModel: self.playerViewModel,
                        lootBagViewModel: lootBagViewModel,
                        pageGeometry: self.pageGeometry)
                }
            }
        }
    }
}

struct ActionsView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContentView {
            GeometryReader { geo in
                ActionsView(
                    playerViewModel: PreviewObjects.playerViewModel,
                    optionsStateManager: OptionsStateManager(playerViewModel: PreviewObjects.playerViewModel),
                    pageGeometry: geo)
            }
        }
    }
}

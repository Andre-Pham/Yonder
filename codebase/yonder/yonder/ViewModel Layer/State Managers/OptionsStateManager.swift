//
//  OptionsStateManager.swift
//  yonder
//
//  Created by Andre Pham on 29/1/2022.
//

import Foundation
import SwiftUI
import Combine

class OptionsStateManager: ObservableObject {
    
    private let playerViewModel: PlayerViewModel
    private var subscriptions: Set<AnyCancellable> = []
    
    @Published private(set) var showOptions = true
    @Published private(set) var showActions = false
    let animation: Animation = .easeOut(duration: 0.3)
    @Published private var optionHeaderText = Strings("optionsMenu.header.default").local
    var optionHeader: String {
        return "[\(self.optionHeaderText)]"
    }
    
    // Weapon option
    var weaponOptionActive: Bool {
        return self.playerViewModel.canEngage
    }
    @Published var weaponActionsActive = false
    
    // Potion option
    var potionOptionActive: Bool {
        return self.playerViewModel.hasUsablePotions
    }
    @Published var potionActionsActive = false
    
    // Consumable option
    var consumableOptionActive: Bool {
        return self.playerViewModel.canConsume
    }
    @Published var consumableActionsActive = false
    
    // Travel option
    var travelOptionActive: Bool {
        return self.playerViewModel.canTravel
    }
    
    // Offer option
    var offerOptionActive: Bool {
        return self.playerViewModel.hasOffers
    }
    @Published var offerActionsActive = false
    
    // Purchase restoration option
    var purchaseRestorationOptionActive: Bool {
        return self.playerViewModel.canPurchaseRestoration
    }
    @Published var purchaseRestorationActionsActive = false
    
    // Shop option
    var shopOptionActive: Bool {
        return self.playerViewModel.canShop
    }
    @Published var shopActionsActive = false
    
    // Enhance option
    var enhanceOptionActive: Bool {
        return self.playerViewModel.canEnhance
    }
    @Published var enhanceActionsActive = false
    
    // Choose loot bag option
    var chooseLootBagOptionActive: Bool {
        return self.playerViewModel.canChooseLootBag
    }
    @Published var chooseLootBagActionsActive = false
    
    // Loot option
    var lootOptionActive: Bool {
        return self.playerViewModel.canLoot
    }
    @Published var lootActionsActive = false
    
    init(playerViewModel: PlayerViewModel) {
        self.playerViewModel = playerViewModel
        
        // Add Subscribers
        
        // If there is a foe, and the foe dies, return to options view
        self.playerViewModel.$locationViewModel.sink(receiveValue: { newValue in
            if let foeViewModel = newValue.getFoeViewModel() {
                foeViewModel.$isDead.sink(receiveValue: { newValue in
                    if newValue {
                        self.closeActions()
                    }
                }).store(in: &self.subscriptions)
            }
        }).store(in: &self.subscriptions)
        
        // If the player is suddenly able to loot (assuming they've selected a loot bag), return to options view
        // If the player is suddenly unable to loot, stop them from taking items - return to options view
        self.playerViewModel.$lootBagViewModel.sink(receiveValue: { _ in
            self.closeActions()
        }).store(in: &self.subscriptions)
    }
    
    func closeActions() {
        self.optionHeaderText = Strings("optionsMenu.header.default").local
        withAnimation(self.animation) {
            self.showOptions = true
            self.showActions = false
            self.weaponActionsActive = false
            self.potionActionsActive = false
            self.consumableActionsActive = false
            self.offerActionsActive = false
            self.purchaseRestorationActionsActive = false
            self.shopActionsActive = false
            self.enhanceActionsActive = false
            self.chooseLootBagActionsActive = false
            self.lootActionsActive = false
        }
    }
    
    func weaponOptionSelected() {
        self.optionHeaderText = Strings("optionsMenu.header.weapon").local
        withAnimation(self.animation) {
            self.showOptions = false
            self.weaponActionsActive = true
            self.showActions = true
        }
    }
    
    func potionOptionSelected() {
        self.optionHeaderText = Strings("optionsMenu.header.potion").local
        withAnimation(self.animation) {
            self.showOptions = false
            self.potionActionsActive = true
            self.showActions = true
        }
    }
    
    func consumableOptionSelected() {
        self.optionHeaderText = Strings("optionsMenu.header.consumable").local
        withAnimation(self.animation) {
            self.showOptions = false
            self.consumableActionsActive = true
            self.showActions = true
        }
    }
    
    func offerOptionSelected() {
        self.optionHeaderText = Strings("optionsMenu.header.offer").local
        withAnimation(self.animation) {
            self.showOptions = false
            self.offerActionsActive = true
            self.showActions = true
        }
    }
    
    func purchaseRestorationOptionSelected() {
        self.optionHeaderText = Strings("optionsMenu.header.restoration").local
        withAnimation(self.animation) {
            self.showOptions = false
            self.purchaseRestorationActionsActive = true
            self.showActions = true
        }
    }
    
    func shopOptionSelected() {
        self.optionHeaderText = Strings("optionsMenu.header.shop").local
        withAnimation(self.animation) {
            self.showOptions = false
            self.shopActionsActive = true
            self.showActions = true
        }
    }
    
    func enhanceOptionSelected() {
        self.optionHeaderText = Strings("optionsMenu.header.enhance").local
        withAnimation(self.animation) {
            self.showOptions = false
            self.enhanceActionsActive = true
            self.showActions = true
        }
    }
    
    func chooseLootBagOptionSelected() {
        self.optionHeaderText = Strings("optionsMenu.header.chooseLootBag").local
        withAnimation(self.animation) {
            self.showOptions = false
            self.chooseLootBagActionsActive = true
            self.showActions = true
        }
    }
    
    func lootOptionSelected() {
        self.optionHeaderText = Strings("optionsMenu.header.loot").local
        withAnimation(self.animation) {
            self.showOptions = false
            self.lootActionsActive = true
            self.showActions = true
        }
    }
    
    func travelOptionSelected(viewRouter: ViewRouter, travelStateManager: TravelStateManager) {
        travelStateManager.setTravellingActive(to: true)
        viewRouter.switchPage(to: .map)
    }
    
}

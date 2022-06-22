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
    
    /// Used as a Bool, but can have its reference saved or passed around.
    class Status {
        // Public so it can be used to for binding
        var isActive: Bool
        
        init(_ status: Bool) {
            self.isActive = status
        }
    }
    
    private let playerViewModel: PlayerViewModel
    private var subscriptions: Set<AnyCancellable> = []
    
    @Published private(set) var showOptions = true
    @Published private var optionHeaderText = Strings.OptionsMenu.Header.Default.local
    var optionHeader: String {
        return "[\(self.optionHeaderText)]"
    }
    
    // Weapon option
    var weaponOptionActive: Bool {
        return self.playerViewModel.canEngage
    }
    @Published var weaponActionsActive = Status(false)
    
    // Potion option
    var potionOptionActive: Bool {
        return self.playerViewModel.canEngage
    }
    @Published var potionActionsActive = Status(false)
    
    // Travel option
    var travelOptionActive: Bool {
        return self.playerViewModel.canTravel
    }
    
    // Offer option
    var offerOptionActive: Bool {
        return self.playerViewModel.hasOffers
    }
    @Published var offerActionsActive = Status(false)
    
    // Purchase restoration option
    var purchaseRestorationOptionActive: Bool {
        return self.playerViewModel.canPurchaseRestoration
    }
    @Published var purchaseRestorationActionsActive = Status(false)
    
    // Shop option
    var shopOptionActive: Bool {
        return self.playerViewModel.canShop
    }
    @Published var shopActionsActive = Status(false)
    
    // Enhance option
    var enhanceOptionActive: Bool {
        return self.playerViewModel.canEnhance
    }
    @Published var enhanceActionsActive = Status(false)
    
    // Whenever an action is set to showing, its reference is passed here
    var activeActions = Status(false)
    
    init(playerViewModel: PlayerViewModel) {
        self.playerViewModel = playerViewModel
        
        // Add Subscribers
        
        // If there is a foe, and the foe dies, return to Options view
        self.playerViewModel.$locationViewModel.sink(receiveValue: { newValue in
            if let foeViewModel = newValue.getFoeViewModel() {
                foeViewModel.$isDead.sink(receiveValue: { newValue in
                    if newValue {
                        self.closeActions()
                    }
                }).store(in: &self.subscriptions)
            }
        }).store(in: &self.subscriptions)
    }
    
    func closeActions() {
        self.optionHeaderText = Strings.OptionsMenu.Header.Default.local
        self.showOptions = true
        self.activeActions.isActive = false
    }
    
    func weaponOptionSelected() {
        self.optionHeaderText = Strings.OptionsMenu.Header.Weapon.local
        self.showOptions = false
        self.weaponActionsActive = Status(true)
        self.activeActions = self.weaponActionsActive
    }
    
    func potionOptionSelected() {
        self.optionHeaderText = Strings.OptionsMenu.Header.Potion.local
        self.showOptions = false
        self.potionActionsActive = Status(true)
        self.activeActions = self.potionActionsActive
    }
    
    func offerOptionSelected() {
        self.optionHeaderText = Strings.OptionsMenu.Header.Offer.local
        self.showOptions = false
        self.offerActionsActive = Status(true)
        self.activeActions = self.offerActionsActive
    }
    
    func purchaseRestorationOptionSelected() {
        self.optionHeaderText = Strings.OptionsMenu.Header.Restoration.local
        self.showOptions = false
        self.purchaseRestorationActionsActive = Status(true)
        self.activeActions = self.purchaseRestorationActionsActive
    }
    
    func shopOptionSelected() {
        self.optionHeaderText = Strings.OptionsMenu.Header.Shop.local
        self.showOptions = false
        self.shopActionsActive = Status(true)
        self.activeActions = self.shopActionsActive
    }
    
    func enhanceOptionSelected() {
        self.optionHeaderText = Strings.OptionsMenu.Header.Enhance.local
        self.showOptions = false
        self.enhanceActionsActive = Status(true)
        self.activeActions = self.enhanceActionsActive
    }
    
    func travelOptionSelected(viewRouter: ViewRouter, travelStateManager: TravelStateManager) {
        travelStateManager.setTravellingActive(to: true)
        viewRouter.switchPage(to: .map)
    }
    
}

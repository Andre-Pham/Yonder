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
    private var foeViewModel: FoeViewModel?
    private var subscriptions: Set<AnyCancellable> = []
    
    @Published private(set) var showOptions = true
    let optionColumns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    @Published private var optionHeaderText = "Your Options"
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
    
    // Whenever an action is set to showing, its reference is passed here
    var activeActions = Status(false)
    
    init(playerViewModel: PlayerViewModel) {
        self.playerViewModel = playerViewModel
        
        // Add Subscribers
        
        // If there is a foe, and the foe dies, return to Options view
        self.playerViewModel.$locationViewModel.sink(receiveValue: { newValue in
            self.foeViewModel = newValue.getFoeViewModel()
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
        self.optionHeaderText = "Your Options"
        self.showOptions = true
        self.activeActions.isActive = false
    }
    
    func weaponOptionSelected() {
        self.optionHeaderText = "Use Weapon"
        self.showOptions = false
        self.weaponActionsActive = Status(true)
        self.activeActions = self.weaponActionsActive
    }
    
    func potionOptionSelected() {
        self.optionHeaderText = "Use Potion"
        self.showOptions = false
        self.potionActionsActive = Status(true)
        self.activeActions = self.potionActionsActive
    }
    
    func travelOptionSelected(viewRouter: ViewRouter, travelStateManager: TravelStateManager) {
        travelStateManager.setTravellingActive(to: true)
        viewRouter.switchPage(to: .map)
    }
    
}

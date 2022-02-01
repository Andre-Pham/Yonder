//
//  OptionsStateManager.swift
//  yonder
//
//  Created by Andre Pham on 29/1/2022.
//

import Foundation
import SwiftUI

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
    
    private let hostileLocationTypes: [LocationType] = [.hostile, .challengeHostile, .boss]
    
    @Published private(set) var showOptions = true
    let optionColumns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    @Published private var optionHeaderText = "Your Options"
    var optionHeader: String {
        return "[\(self.optionHeaderText)]"
    }
    
    var weaponOptionActive: Bool {
        return self.hostileLocationTypes.contains(self.playerViewModel.locationViewModel.type)
    }
    @Published var weaponActionsActive = Status(false)
    @Published private(set) var travelOptionActive = true
    @Published var travelActionsActive = Status(false)
    
    // Whenever an action is set to showing, its reference is passed here
    var activeActions = Status(false)
    
    init(playerViewModel: PlayerViewModel) {
        self.playerViewModel = playerViewModel
    }
    
    func closeActions() {
        self.optionHeaderText = "Your Options"
        self.showOptions = true
        self.activeActions = Status(false)
    }
    
    func weaponOptionSelected() {
        self.optionHeaderText = "Use Weapon"
        self.showOptions = false
        self.weaponActionsActive = Status(true)
        self.activeActions = self.weaponActionsActive
    }
    
    func travelOptionSelected() {
        self.travelActionsActive = Status(true)
        self.activeActions = self.travelActionsActive
    }
    
}

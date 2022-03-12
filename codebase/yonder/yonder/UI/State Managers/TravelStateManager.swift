//
//  TravelStateManager.swift
//  yonder
//
//  Created by Andre Pham on 29/1/2022.
//

import Foundation
import SwiftUI

class TravelStateManager: ObservableObject {
    
    private let playerViewModel: PlayerViewModel
    @Published private(set) var travellingActive = false
    private var travellingAllowed: Bool {
        return self.playerViewModel.canTravel
    }
    
    init(playerViewModel: PlayerViewModel) {
        self.playerViewModel = playerViewModel
    }
    
    func toggleTravellingActiveStateDisabled() -> Bool {
        return !self.travellingActive && !self.travellingAllowed
    }
    
    func toggleTravellingActiveState() {
        if !self.toggleTravellingActiveStateDisabled() {
            self.travellingActive.toggle()
        }
    }
    
    func setTravellingActive(to state: Bool) {
        if self.travellingActive || self.travellingAllowed {
            self.travellingActive = state
        }
    }
    
}

//
//  TravelStateManager.swift
//  yonder
//
//  Created by Andre Pham on 29/1/2022.
//

import Foundation
import SwiftUI

class TravelStateManager: ObservableObject {
    
    @Published private(set) var travellingActive = false
    @Published private(set) var travellingAllowed = true
    
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

//
//  TravelStateManager.swift
//  yonder
//
//  Created by Andre Pham on 29/1/2022.
//

import Foundation
import SwiftUI
import Combine

class TravelStateManager: ObservableObject {
    
    private let playerViewModel = gameManager.playerVM
    private var subscriptions: Set<AnyCancellable> = []
    @Published private(set) var travellingActive = false
    var travellingAllowed: Bool {
        return self.playerViewModel.canTravel
    }
    
    init() {
        // Updates travel options reactively to player
        self.playerViewModel.objectWillChange.sink(receiveValue: { _ in self.objectWillChange.send() }).store(in: &self.subscriptions)
    }
    
    func toggleTravellingActiveState() {
        if self.travellingAllowed {
            self.travellingActive.toggle()
        }
    }
    
    func setTravellingActive(to state: Bool) {
        if self.travellingActive || self.travellingAllowed {
            self.travellingActive = state
        }
    }
    
}

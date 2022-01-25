//
//  PlayerLocationViewModel.swift
//  yonder
//
//  Created by Andre Pham on 11/12/21.
//

import Foundation
import Combine
import SwiftUI

class PlayerLocationViewModel: ObservableObject {
    
    @Published private(set) var locationViewModel: LocationViewModel
    var id: UUID {
        return self.locationViewModel.id
    }
    private var subscriptions: Set<AnyCancellable> = []
    
    init(player: Player) {
        self.locationViewModel = LocationViewModel(player.location)
        
        // Add Subscribers
        
        player.$location.sink(receiveValue: { newValue in
            self.locationViewModel = LocationViewModel(newValue)
        }).store(in: &self.subscriptions)
    }
    
}

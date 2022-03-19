//
//  InventorySheetsStateManager.swift
//  yonder
//
//  Created by Andre Pham on 3/2/2022.
//

import Foundation
import Combine

class InventorySheetsStateManager: ObservableObject {
    
    private var subscriptions: Set<AnyCancellable> = []
    
    @Published var weaponSheetBindings: [Bool]
    
    init(playerViewModel: PlayerViewModel) {
        self.weaponSheetBindings = Array(repeating: false, count: playerViewModel.weaponViewModels.count)
        
        // Add Subscribers
        
        playerViewModel.$weaponViewModels.sink(receiveValue: { newValue in
            self.weaponSheetBindings = Array(repeating: false, count: newValue.count)
        }).store(in: &self.subscriptions)
    }
    
    func presentWeaponSheet(at index: Int) {
        self.weaponSheetBindings[index] = true
    }
    
}

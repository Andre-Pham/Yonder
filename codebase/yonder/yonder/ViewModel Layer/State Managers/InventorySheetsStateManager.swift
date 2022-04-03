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
    
    @Published var armorSheetBindings: [Bool]
    @Published var weaponSheetBindings: [Bool]
    @Published var potionSheetBindings: [Bool]
    
    init(playerViewModel: PlayerViewModel) {
        self.armorSheetBindings = Array(repeating: false, count: playerViewModel.allArmorViewModels.count)
        self.weaponSheetBindings = Array(repeating: false, count: playerViewModel.weaponViewModels.count)
        self.potionSheetBindings = Array(repeating: false, count: playerViewModel.potionViewModels.count)
        
        // Add Subscribers
        
        playerViewModel.$weaponViewModels.sink(receiveValue: { newValue in
            self.weaponSheetBindings = Array(repeating: false, count: newValue.count)
        }).store(in: &self.subscriptions)
        
        playerViewModel.$potionViewModels.sink(receiveValue: { newValue in
            self.potionSheetBindings = Array(repeating: false, count: newValue.count)
        }).store(in: &self.subscriptions)
    }
    
    func presentArmorSheet(at index: Int) {
        self.armorSheetBindings[index] = true
    }
    
    func presentWeaponSheet(at index: Int) {
        self.weaponSheetBindings[index] = true
    }
    
    func presentPotionSheet(at index: Int) {
        self.potionSheetBindings[index] = true
    }
    
}

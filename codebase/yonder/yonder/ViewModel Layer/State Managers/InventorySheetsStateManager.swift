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
    @Published var consumableSheetBindings: [Bool]
    @Published var accessorySheetBindings: [Bool]
    @Published var peripheralAccessorySheetBinding: Bool = false
    
    init(playerViewModel: PlayerViewModel) {
        self.armorSheetBindings = Array(repeating: false, count: playerViewModel.allArmorViewModels.count)
        self.weaponSheetBindings = Array(repeating: false, count: playerViewModel.weaponViewModels.count)
        self.potionSheetBindings = Array(repeating: false, count: playerViewModel.potionViewModels.count)
        self.consumableSheetBindings = Array(repeating: false, count: playerViewModel.consumableViewModels.count)
        self.accessorySheetBindings = Array(repeating: false, count: playerViewModel.accessoryViewModels.count)
        
        // Add Subscribers
        
        playerViewModel.$weaponViewModels.sink(receiveValue: { newValue in
            self.weaponSheetBindings = Array(repeating: false, count: newValue.count)
        }).store(in: &self.subscriptions)
        
        playerViewModel.$potionViewModels.sink(receiveValue: { newValue in
            self.potionSheetBindings = Array(repeating: false, count: newValue.count)
        }).store(in: &self.subscriptions)
        
        playerViewModel.$consumableViewModels.sink(receiveValue: { newValue in
            self.consumableSheetBindings = Array(repeating: false, count: newValue.count)
        }).store(in: &self.subscriptions)
        
        playerViewModel.$accessoryViewModels.sink(receiveValue: { newValue in
            self.accessorySheetBindings = Array(repeating: false, count: newValue.count)
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
    
    func presentConsumableSheet(at index: Int) {
        self.consumableSheetBindings[index] = true
    }
    
    func presentAccessorySheet(at index: Int) {
        self.accessorySheetBindings[index] = true
    }
    
}

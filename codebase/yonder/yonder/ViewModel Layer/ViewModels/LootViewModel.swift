//
//  LootViewModel.swift
//  yonder
//
//  Created by Andre Pham on 4/1/2024.
//

import Foundation
import Combine
import SwiftUI

class LootViewModel: ObservableObject {
    
    // loot can be used within the ViewModel layer, but Views should only interact with ViewModels (not the Model layer)
    private(set) var loot: Loot
    private var subscriptions: Set<AnyCancellable> = []
    
    @Published private(set) var armorViewModelLoot: [ArmorViewModel]
    @Published private(set) var weaponViewModelLoot: [WeaponViewModel]
    @Published private(set) var potionViewModelLoot: [PotionViewModel]
    @Published private(set) var accessoryViewModelLoot: [AccessoryViewModel]
    @Published private(set) var consumableViewModelLoot: [ConsumableViewModel]
    @Published private(set) var goldLoot: Int
    public let id: UUID
    
    init(_ loot: Loot) {
        self.loot = loot
        
        self.armorViewModelLoot = loot.armorLoot.map { ArmorViewModel($0) }
        self.weaponViewModelLoot = loot.weaponLoot.map { WeaponViewModel($0) }
        self.potionViewModelLoot = loot.potionLoot.map { PotionViewModel($0) }
        self.accessoryViewModelLoot = loot.accessoryLoot.map { AccessoryViewModel($0) }
        self.consumableViewModelLoot = loot.consumableLoot.map { ConsumableViewModel($0) }
        self.goldLoot = loot.goldLoot
        self.id = loot.id
        
        self.loot.$armorLoot.sink(receiveValue: { newValue in
            self.armorViewModelLoot = newValue.map { ArmorViewModel($0) }
        }).store(in: &self.subscriptions)
        
        self.loot.$weaponLoot.sink(receiveValue: { newValue in
            self.weaponViewModelLoot = newValue.map { WeaponViewModel($0) }
        }).store(in: &self.subscriptions)
        
        self.loot.$potionLoot.sink(receiveValue: { newValue in
            self.potionViewModelLoot = newValue.map { PotionViewModel($0) }
        }).store(in: &self.subscriptions)
        
        self.loot.$accessoryLoot.sink(receiveValue: { newValue in
            self.accessoryViewModelLoot = newValue.map { AccessoryViewModel($0) }
        }).store(in: &self.subscriptions)
        
        self.loot.$consumableLoot.sink(receiveValue: { newValue in
            self.consumableViewModelLoot = newValue.map { ConsumableViewModel($0) }
        }).store(in: &self.subscriptions)
        
        self.loot.$goldLoot.sink(receiveValue: { newValue in
            self.goldLoot = newValue
        }).store(in: &self.subscriptions)
    }
    
    func collectArmor(armorViewModel: ArmorViewModel, playerViewModel: PlayerViewModel) {
        self.loot.collectArmor(id: armorViewModel.id, player: playerViewModel.player)
    }
    
    func collectWeapon(weaponViewModel: WeaponViewModel, playerViewModel: PlayerViewModel) {
        self.loot.collectWeapon(id: weaponViewModel.id, player: playerViewModel.player)
    }
    
    func collectPotion(potionViewModel: PotionViewModel, playerViewModel: PlayerViewModel) {
        self.loot.collectPotion(id: potionViewModel.id, player: playerViewModel.player)
    }
    
    func collectAccessory(accessoryViewModel: AccessoryViewModel, replacing: UUID?, playerViewModel: PlayerViewModel) {
        self.loot.collectAccessory(id: accessoryViewModel.id, replacing: replacing, player: playerViewModel.player)
    }
    
    func collectConsumable(consumableViewModel: ConsumableViewModel, playerViewModel: PlayerViewModel) {
        self.loot.collectConsumable(id: consumableViewModel.id, player: playerViewModel.player)
    }
    
    func collectGold(playerViewModel: PlayerViewModel) {
        self.loot.collectGold(player: playerViewModel.player)
    }
    
}

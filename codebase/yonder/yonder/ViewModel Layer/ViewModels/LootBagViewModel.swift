//
//  LootBagViewModel.swift
//  yonder
//
//  Created by Andre Pham on 17/7/2022.
//

import Foundation
import Combine
import SwiftUI

class LootBagViewModel: ObservableObject {
    
    // lootBag can be used within the ViewModel layer, but Views should only interact with ViewModels (not the Model layer)
    private(set) var lootBag: LootBag
    private var subscriptions: Set<AnyCancellable> = []
    
    @Published private(set) var armorViewModelLoot: [ArmorViewModel]
    @Published private(set) var weaponViewModelLoot: [WeaponViewModel]
    @Published private(set) var potionViewModelLoot: [PotionViewModel]
    @Published private(set) var accessoryViewModelLoot: [AccessoryViewModel]
    @Published private(set) var consumableViewModelLoot: [ConsumableViewModel]
    @Published private(set) var goldLoot: Int
    public let name: String
    public let description: String
    public let id: UUID
    
    init(_ lootBag: LootBag) {
        self.lootBag = lootBag
        
        self.armorViewModelLoot = lootBag.armorLoot.map { ArmorViewModel($0) }
        self.weaponViewModelLoot = lootBag.weaponLoot.map { WeaponViewModel($0) }
        self.potionViewModelLoot = lootBag.potionLoot.map { PotionViewModel($0) }
        self.accessoryViewModelLoot = lootBag.accessoryLoot.map { AccessoryViewModel($0) }
        self.consumableViewModelLoot = lootBag.consumableLoot.map { ConsumableViewModel($0) }
        self.goldLoot = lootBag.goldLoot
        self.name = lootBag.name
        self.description = lootBag.description
        self.id = lootBag.id
        
        self.lootBag.$armorLoot.sink(receiveValue: { newValue in
            self.armorViewModelLoot = newValue.map { ArmorViewModel($0) }
        }).store(in: &self.subscriptions)
        
        self.lootBag.$weaponLoot.sink(receiveValue: { newValue in
            self.weaponViewModelLoot = newValue.map { WeaponViewModel($0) }
        }).store(in: &self.subscriptions)
        
        self.lootBag.$potionLoot.sink(receiveValue: { newValue in
            self.potionViewModelLoot = newValue.map { PotionViewModel($0) }
        }).store(in: &self.subscriptions)
        
        self.lootBag.$accessoryLoot.sink(receiveValue: { newValue in
            self.accessoryViewModelLoot = newValue.map { AccessoryViewModel($0) }
        }).store(in: &self.subscriptions)
        
        self.lootBag.$consumableLoot.sink(receiveValue: { newValue in
            self.consumableViewModelLoot = newValue.map { ConsumableViewModel($0) }
        }).store(in: &self.subscriptions)
        
        self.lootBag.$goldLoot.sink(receiveValue: { newValue in
            self.goldLoot = newValue
        }).store(in: &self.subscriptions)
    }
    
    func collectArmor(armorViewModel: ArmorViewModel, playerViewModel: PlayerViewModel) {
        self.lootBag.collectArmor(id: armorViewModel.id, player: playerViewModel.player)
    }
    
    func collectWeapon(weaponViewModel: WeaponViewModel, playerViewModel: PlayerViewModel) {
        self.lootBag.collectWeapon(id: weaponViewModel.id, player: playerViewModel.player)
    }
    
    func collectPotion(potionViewModel: PotionViewModel, playerViewModel: PlayerViewModel) {
        self.lootBag.collectPotion(id: potionViewModel.id, player: playerViewModel.player)
    }
    
    func collectAccessory(accessoryViewModel: AccessoryViewModel, replacing: UUID?, playerViewModel: PlayerViewModel) {
        self.lootBag.collectAccessory(id: accessoryViewModel.id, replacing: replacing, player: playerViewModel.player)
    }
    
    func collectConsumable(consumableViewModel: ConsumableViewModel, playerViewModel: PlayerViewModel) {
        self.lootBag.collectConsumable(id: consumableViewModel.id, player: playerViewModel.player)
    }
    
    func collectGold(playerViewModel: PlayerViewModel) {
        self.lootBag.collectGold(player: playerViewModel.player)
    }
    
}

//
//  PlayerViewModel.swift
//  yonder
//
//  Created by Andre Pham on 11/12/21.
//

import Foundation
import Combine
import SwiftUI

class PlayerViewModel: ActorViewModel {
    
    // player can be used within the ViewModel layer, but Views should only interact with ViewModels (not the Model layer)
    private(set) var player: Player
    private var subscriptions: Set<AnyCancellable> = []
    
    @Published private(set) var health: Int
    @Published private(set) var maxHealth: Int
    @Published private(set) var armorPoints: Int
    @Published private(set) var maxArmorPoints: Int
    @Published private(set) var gold: Int
    
    @Published private(set) var locationViewModel: LocationViewModel
    @Published private(set) var lootBagViewModel: LootBagViewModel?
    @Published private(set) var weaponViewModels: [WeaponViewModel] {
        didSet {
            // Changes to any WeaponViewModel will be published to the UI
            for weapon in self.weaponViewModels {
                weapon.objectWillChange.sink(receiveValue: { _ in self.objectWillChange.send() }).store(in: &self.subscriptions)
            }
        }
    }
    @Published private(set) var applicableWeaponViewModels: [WeaponViewModel] {
        didSet {
            // Changes to any WeaponViewModel will be published to the UI
            for weapon in self.applicableWeaponViewModels {
                weapon.objectWillChange.sink(receiveValue: { _ in self.objectWillChange.send() }).store(in: &self.subscriptions)
            }
        }
    }
    @Published private(set) var potionViewModels: [PotionViewModel] {
        didSet {
            // Changes to any PotionViewModel will be published to the UI
            for potion in self.potionViewModels {
                potion.objectWillChange.sink(receiveValue: { _ in self.objectWillChange.send() }).store(in: &self.subscriptions)
            }
        }
    }
    @Published private(set) var consumableViewModels: [ConsumableViewModel] {
        didSet {
            // Changes to any ConsumableViewModel will be published to the UI
            for consumable in self.consumableViewModels {
                consumable.objectWillChange.sink(receiveValue: { _ in self.objectWillChange.send() }).store(in: &self.subscriptions)
            }
        }
    }
    @Published private(set) var accessoryViewModels: [AccessoryViewModel] {
        didSet {
            // Changes to any AccessoryViewModel will be published to the UI
            for accessory in self.accessoryViewModels {
                accessory.objectWillChange.sink(receiveValue: { _ in self.objectWillChange.send() }).store(in: &self.subscriptions)
            }
        }
    }
    var accessorySlotCount: Int {
        return self.player.accessorySlots.accessorySlotCount
    }
    var accessorySlotsFull: Bool {
        return self.player.accessorySlots.accessorySlotsFull
    }
    var emptyAccessorySlotsCount: Int {
        return self.accessorySlotCount - self.accessoryViewModels.count
    }
    @Published private(set) var peripheralAccessoryViewModel: AccessoryViewModel
    @Published private(set) var headArmorViewModel: ArmorViewModel
    @Published private(set) var bodyArmorViewModel: ArmorViewModel
    @Published private(set) var legsArmorViewModel: ArmorViewModel
    var allArmorViewModels: [ArmorViewModel] {
        return [self.headArmorViewModel, self.bodyArmorViewModel, self.legsArmorViewModel]
    }
    override var allBuffs: [BuffViewModel] {
        var allBuffs = super.allBuffs
        for armorViewModel in self.allArmorViewModels {
            allBuffs.append(contentsOf: armorViewModel.buffViewModels)
        }
        for accessoryViewModel in self.accessoryViewModels {
            allBuffs.append(contentsOf: accessoryViewModel.buffViewModels)
        }
        allBuffs.append(contentsOf: self.peripheralAccessoryViewModel.buffViewModels)
        return allBuffs
    }
    var allEquipmentEffects: [EquipmentEffectViewModel] {
        var allEquipmentEffects = [EquipmentEffectViewModel]()
        for armorViewModel in self.allArmorViewModels {
            allEquipmentEffects.append(contentsOf: armorViewModel.equipmentEffectViewModels)
        }
        for accessoryViewModel in self.accessoryViewModels {
            allEquipmentEffects.append(contentsOf: accessoryViewModel.equipmentEffectViewModels)
        }
        allEquipmentEffects.append(contentsOf: self.peripheralAccessoryViewModel.equipmentEffectViewModels)
        return allEquipmentEffects
    }
    var canEngage: Bool {
        return self.locationViewModel.playerCanEngage
    }
    var hasUsablePotions: Bool {
        let potionsAvailableForDuringCombat = self.canEngage && !self.potionViewModels.isEmpty
        let nonCombatPotionsAvailable = self.potionViewModels.contains(where: { !$0.requiresFoeForUsage })
        return potionsAvailableForDuringCombat || nonCombatPotionsAvailable
    }
    var canConsume: Bool {
        let consumablesAvailableForDuringCombat = self.canEngage && !self.consumableViewModels.isEmpty
        let nonCombatConsumablesAvailable = self.consumableViewModels.contains(where: { !$0.requiresFoeForUsage })
        return consumablesAvailableForDuringCombat || nonCombatConsumablesAvailable
    }
    var canTravel: Bool {
        let notInCombat = !self.canEngage
        let noLootAvailable = !self.canLoot && !self.canChooseLootBag
        return notInCombat && noLootAvailable
    }
    var hasOffers: Bool {
        return self.locationViewModel.playerHasOffers
    }
    var canPurchaseRestoration: Bool {
        return self.locationViewModel.playerCanPurchaseRestoration
    }
    var canShop: Bool {
        return self.locationViewModel.playerCanShop
    }
    var canEnhance: Bool {
        return self.locationViewModel.playerCanEnhance
    }
    var canChooseLootBag: Bool {
        return self.locationViewModel.playerCanChooseLootBag
    }
    var canLoot: Bool {
        return self.lootBagViewModel != nil
    }
    
    init(_ player: Player) {
        self.player = player
        
        // Set properties to match Player
        
        self.health = self.player.health
        self.maxHealth = self.player.maxHealth
        self.armorPoints = self.player.armorPoints
        self.maxArmorPoints = self.player.maxArmorPoints
        self.gold = self.player.gold
        
        // Set other view models
        
        self.locationViewModel = LocationViewModel(self.player.location)
        self.lootBagViewModel = self.player.loot == nil ? nil : LootBagViewModel(self.player.loot!)
        self.weaponViewModels = self.player.weapons.map { WeaponViewModel($0) }
        self.applicableWeaponViewModels = self.player.getApplicableWeapons().map { WeaponViewModel($0) }
        self.potionViewModels = self.player.potions.map { PotionViewModel($0) }
        self.consumableViewModels = self.player.consumables.map { ConsumableViewModel($0) }
        self.accessoryViewModels = self.player.accessorySlots.accessories.map { AccessoryViewModel($0) }
        self.peripheralAccessoryViewModel = AccessoryViewModel(self.player.accessorySlots.peripheralAccessory)
        self.headArmorViewModel = ArmorViewModel(self.player.headArmor)
        self.bodyArmorViewModel = ArmorViewModel(self.player.bodyArmor)
        self.legsArmorViewModel = ArmorViewModel(self.player.legsArmor)
        
        super.init(self.player)
        
        // Add Subscribers
        
        self.player.$health.sink(receiveValue: { newValue in
            self.health = newValue
        }).store(in: &self.subscriptions)
        
        self.player.$maxHealth.sink(receiveValue: { newValue in
            self.maxHealth = newValue
        }).store(in: &self.subscriptions)
        
        self.player.$armorPoints.sink(receiveValue: { newValue in
            self.armorPoints = newValue
        }).store(in: &self.subscriptions)
        
        for armorPiece in self.player.allArmorPieces {
            armorPiece.$armorPoints.sink(receiveValue: { _ in
                self.maxArmorPoints = self.player.maxArmorPoints
            }).store(in: &self.subscriptions)
        }
        self.player.$headArmor.sink(receiveValue: { newValue in
            self.headArmorViewModel = ArmorViewModel(newValue)
            self.maxArmorPoints = self.player.maxArmorPoints
            self.headArmorViewModel.$armorPoints.sink(receiveValue: { _ in
                self.maxArmorPoints = self.player.maxArmorPoints
            }).store(in: &self.subscriptions)
        }).store(in: &self.subscriptions)
        self.player.$bodyArmor.sink(receiveValue: { newValue in
            self.bodyArmorViewModel = ArmorViewModel(newValue)
            self.maxArmorPoints = self.player.maxArmorPoints
            self.bodyArmorViewModel.$armorPoints.sink(receiveValue: { _ in
                self.maxArmorPoints = self.player.maxArmorPoints
            }).store(in: &self.subscriptions)
        }).store(in: &self.subscriptions)
        self.player.$legsArmor.sink(receiveValue: { newValue in
            self.legsArmorViewModel = ArmorViewModel(newValue)
            self.maxArmorPoints = self.player.maxArmorPoints
            self.legsArmorViewModel.$armorPoints.sink(receiveValue: { _ in
                self.maxArmorPoints = self.player.maxArmorPoints
            }).store(in: &self.subscriptions)
        }).store(in: &self.subscriptions)
        
        self.player.accessorySlots.$accessories.sink(receiveValue: { newValue in
            self.accessoryViewModels = newValue.map { AccessoryViewModel($0) }
            self.maxArmorPoints = self.player.maxArmorPoints
        }).store(in: &self.subscriptions)
        
        self.player.accessorySlots.$peripheralAccessory.sink(receiveValue: { newValue in
            self.peripheralAccessoryViewModel = AccessoryViewModel(newValue)
            self.maxArmorPoints = self.player.maxArmorPoints
        }).store(in: &self.subscriptions)
        
        self.player.$gold.sink(receiveValue: { newValue in
            self.gold = newValue
        }).store(in: &self.subscriptions)
        
        self.player.$locationID.sink(receiveValue: { newValue in
            self.locationViewModel = LocationViewModel(self.player.location)
        }).store(in: &self.subscriptions)
        
        self.player.$loot.sink(receiveValue: { newValue in
            self.lootBagViewModel = newValue == nil ? nil : LootBagViewModel(newValue!)
        }).store(in: &self.subscriptions)
        
        self.player.$weapons.sink(receiveValue: { newValue in
            self.weaponViewModels = newValue.map { WeaponViewModel($0) }
            self.applicableWeaponViewModels = self.player.getApplicableWeapons().map { WeaponViewModel($0) }
        }).store(in: &self.subscriptions)
        
        self.player.$potions.sink(receiveValue: { newValue in
            self.potionViewModels = newValue.map { PotionViewModel($0) }
        }).store(in: &self.subscriptions)
        
        self.player.$consumables.sink(receiveValue: { newValue in
            self.consumableViewModels = newValue.map { ConsumableViewModel($0) }
        }).store(in: &self.subscriptions)
    }
    
    func equipArmor(_ armorViewModel: ArmorViewModel) {
        self.player.equipArmor(armorViewModel.armor)
    }
    
    func equipAccessory(_ accessoryViewModel: AccessoryViewModel, replacing: UUID?) {
        self.player.equipAccessory(accessoryViewModel.accessory, replacing: replacing)
    }
    
    func unequipAccessory(_ accessoryViewModel: AccessoryViewModel, cacheLocation: Bool = false) {
        self.player.unequipAccessory(accessoryViewModel.accessory, cacheLocation: cacheLocation)
    }
    
    func unequipAccessory(id: UUID, cacheLocation: Bool = false) {
        self.player.unequipAccessory(id: id, cacheLocation: cacheLocation)
    }
    
    func travel(to locationViewModel: LocationViewModel) {
        self.player.travel(to: locationViewModel.location)
    }
    
    func use(weaponViewModel: WeaponViewModel) {
        guard self.locationViewModel.location is FoeLocation else {
            assertionFailure("Weapon was used whilst location has no foe - hence no target")
            return
        }
        guard !(self.locationViewModel.location as! FoeLocation).foe!.isDead && weaponViewModel.remainingUses > 0 else {
            // Illegal call - buttons can be triggered before they disappear if tapped fast enough
            return
        }
        self.player.useWeaponWhere(opposition: (self.locationViewModel.location as! FoeLocation).foe!, weapon: weaponViewModel.item as! Weapon)
    }
    
    func use(potionViewModel: PotionViewModel) {
        guard self.locationViewModel.location is FoeLocation || !potionViewModel.requiresFoeForUsage else {
            assertionFailure("Potion was used whilst location has no foe - hence no target")
            return
        }
        self.player.usePotionWhere(opposition: (self.locationViewModel.location as? FoeLocation)?.foe, potion: potionViewModel.item as! Potion)
    }
    
    func use(consumableViewModel: ConsumableViewModel) {
        self.player.useConsumableWhere(opposition: (self.locationViewModel.location as? FoeLocation)?.foe, consumable: consumableViewModel.item as! Consumable)
    }
    
    func getIndicativeDamage(itemViewModel: ItemViewModel, opposition: FoeViewModel) -> Int {
        return self.player.getIndicativeDamage(of: itemViewModel.item, opposition: opposition.foe)
    }
    
    func getIndicativeRestorationString(itemViewModel: ItemViewModel) -> String {
        let (healthRestoration, armorPointsRestoration) = self.player.getIndicativeRestoration(of: itemViewModel.item)
        return "(\(healthRestoration) \(Strings("stat.health").local) / \(armorPointsRestoration) \(Strings("stat.shields").local))"
    }
    
    func getPassiveIndicativeDamage(itemViewModel: ItemViewModel) -> Int {
        return self.player.getIndicativeDamage(of: itemViewModel.item, opposition: NoActor())
    }
    
    func getIndicativePrice(from price: Int) -> Int {
        return self.player.getIndicativePrice(from: price)
    }
    
    func getIndicativePayout(from amount: Int) -> Int {
        return self.player.getIndicativePayout(from: amount)
    }
    
    func getIndicativeArmorPointsRestoration(of itemViewModel: ItemViewModel) -> Int {
        return self.player.getIndicativeArmorPointsRestoration(of: itemViewModel.item)
    }
    
    func getIndicativeHealthRestoration(of itemViewModel: ItemViewModel) -> Int {
        return self.player.getIndicativeHealthRestoration(of: itemViewModel.item)
    }
    
    func finishLooting() {
        self.player.setLoot(to: nil)
    }
    
}

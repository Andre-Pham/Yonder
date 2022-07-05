//
//  PlayerViewModel.swift
//  yonder
//
//  Created by Andre Pham on 11/12/21.
//

import Foundation
import Combine
import SwiftUI

class PlayerViewModel: ObservableObject {
    
    // player can be used within the ViewModel layer, but Views should only interact with ViewModels (not the Model layer)
    private(set) var player: Player
    private var subscriptions: Set<AnyCancellable> = []
    
    @Published private(set) var health: Int
    @Published private(set) var maxHealth: Int
    @Published private(set) var armorPoints: Int
    @Published private(set) var maxArmorPoints: Int
    @Published private(set) var gold: Int
    
    @Published private(set) var locationViewModel: LocationViewModel
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
    @Published private(set) var buffViewModels: [BuffViewModel] {
        didSet {
            // Changes to any BuffViewModel will be published to the UI
            for buff in self.buffViewModels {
                buff.objectWillChange.sink(receiveValue: { _ in self.objectWillChange.send() }).store(in: &self.subscriptions)
            }
        }
    }
    @Published private(set) var statusEffectViewModels: [StatusEffectViewModel] {
        didSet {
            // Changes to any StatusEffectViewModel will be published to the UI
            for statusEffect in self.statusEffectViewModels {
                statusEffect.objectWillChange.sink(receiveValue: { _ in self.objectWillChange.send() }).store(in: &self.subscriptions)
            }
        }
    }
    @Published private(set) var headArmorViewModel: ArmorViewModel
    @Published private(set) var bodyArmorViewModel: ArmorViewModel
    @Published private(set) var legsArmorViewModel: ArmorViewModel
    var allArmorViewModels: [ArmorViewModel] {
        return [self.headArmorViewModel, self.bodyArmorViewModel, self.legsArmorViewModel]
    }
    var allBuffs: [BuffViewModel] {
        var allBuffs = Array(self.buffViewModels)
        for armorViewModel in self.allArmorViewModels {
            allBuffs.append(contentsOf: armorViewModel.buffViewModels)
        }
        return allBuffs
    }
    var canEngage: Bool {
        return self.locationViewModel.playerCanEngage
    }
    var canTravel: Bool {
        return !self.canEngage || self.canEngage && self.self.locationViewModel.getFoeViewModel()?.isDead ?? true
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
    
    init(_ player: Player) {
        self.player = player
        
        // Set properties to match Player
        
        self.health = self.player.health
        self.maxHealth = self.player.maxHealth
        self.armorPoints = self.player.armorPoints
        self.maxArmorPoints = self.player.getMaxArmorPoints()
        self.gold = self.player.gold
        
        // Set other view models
        
        self.locationViewModel = LocationViewModel(self.player.location)
        self.weaponViewModels = self.player.weapons.map { WeaponViewModel($0) }
        self.applicableWeaponViewModels = self.player.getApplicableWeapons().map { WeaponViewModel($0) }
        self.potionViewModels = self.player.potions.map { PotionViewModel($0) }
        self.buffViewModels = self.player.buffs.map { BuffViewModel($0) }
        self.statusEffectViewModels = self.player.statusEffects.map { StatusEffectViewModel($0) }
        self.headArmorViewModel = ArmorViewModel(self.player.headArmor)
        self.bodyArmorViewModel = ArmorViewModel(self.player.bodyArmor)
        self.legsArmorViewModel = ArmorViewModel(self.player.legsArmor)
        
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
                self.maxArmorPoints = self.player.getMaxArmorPoints()
            }).store(in: &self.subscriptions)
        }
        self.player.$headArmor.sink(receiveValue: { newValue in
            self.headArmorViewModel = ArmorViewModel(newValue)
            self.maxArmorPoints = self.player.getMaxArmorPoints()
            self.headArmorViewModel.$armorPoints.sink(receiveValue: { _ in
                self.maxArmorPoints = self.player.getMaxArmorPoints()
            }).store(in: &self.subscriptions)
        }).store(in: &self.subscriptions)
        self.player.$bodyArmor.sink(receiveValue: { newValue in
            self.bodyArmorViewModel = ArmorViewModel(newValue)
            self.maxArmorPoints = self.player.getMaxArmorPoints()
            self.bodyArmorViewModel.$armorPoints.sink(receiveValue: { _ in
                self.maxArmorPoints = self.player.getMaxArmorPoints()
            }).store(in: &self.subscriptions)
        }).store(in: &self.subscriptions)
        self.player.$legsArmor.sink(receiveValue: { newValue in
            self.legsArmorViewModel = ArmorViewModel(newValue)
            self.maxArmorPoints = self.player.getMaxArmorPoints()
            self.legsArmorViewModel.$armorPoints.sink(receiveValue: { _ in
                self.maxArmorPoints = self.player.getMaxArmorPoints()
            }).store(in: &self.subscriptions)
        }).store(in: &self.subscriptions)
        
        self.player.$gold.sink(receiveValue: { newValue in
            self.gold = newValue
        }).store(in: &self.subscriptions)
        
        self.player.$location.sink(receiveValue: { newValue in
            self.locationViewModel = LocationViewModel(newValue)
        }).store(in: &self.subscriptions)
        
        self.player.$weapons.sink(receiveValue: { newValue in
            self.weaponViewModels = newValue.map { WeaponViewModel($0) }
            self.applicableWeaponViewModels = self.player.getApplicableWeapons().map { WeaponViewModel($0) }
        }).store(in: &self.subscriptions)
        
        self.player.$potions.sink(receiveValue: { newValue in
            self.potionViewModels = newValue.map { PotionViewModel($0) }
        }).store(in: &self.subscriptions)
        
        self.player.$buffs.sink(receiveValue: { newValue in
            self.buffViewModels = newValue.map { BuffViewModel($0) }
        }).store(in: &self.subscriptions)
        
        self.player.$statusEffects.sink(receiveValue: { newValue in
            self.statusEffectViewModels = newValue.map { StatusEffectViewModel($0) }
        }).store(in: &self.subscriptions)
    }
    
    func equipArmor(_ armor: ArmorAbstract) {
        self.player.equipArmor(armor)
    }
    
    func travel(to locationViewModel: LocationViewModel) {
        self.player.travel(to: locationViewModel.location)
    }
    
    func use(weaponViewModel: WeaponViewModel) {
        guard self.locationViewModel.location is FoeLocation else {
            YonderDebugging.printError(message: "Weapon was used whilst location has no foe - hence no target", functionName: #function, className: "\(type(of: self))")
            return
        }
        guard !(self.locationViewModel.location as! FoeLocation).foe.isDead && weaponViewModel.remainingUses > 0 else {
            // Illegal call - buttons can be triggered before they disappear if tapped fast enough
            return
        }
        self.player.useWeaponWhere(opposition: (self.locationViewModel.location as! FoeLocation).foe, weapon: weaponViewModel.item as! Weapon)
    }
    
    func use(potionViewModel: PotionViewModel) {
        guard self.locationViewModel.location is FoeLocation else {
            YonderDebugging.printError(message: "Potion was used whilst location has no foe - hence no target", functionName: #function, className: "\(type(of: self))")
            return
        }
        self.player.usePotionWhere(opposition: (self.locationViewModel.location as! FoeLocation).foe, potion: potionViewModel.item as! PotionAbstract)
    }
    
    func getIndicativeDamage(itemViewModel: ItemViewModel, opposition: FoeViewModel) -> Int {
        return self.player.getIndicativeDamage(of: itemViewModel.item, opposition: opposition.foe)
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
    
}

//
//  PlayerViewModel.swift
//  yonder
//
//  Created by Andre Pham on 11/12/21.
//

import Foundation
import Combine

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
    @Published private(set) var weaponViewModels: [WeaponViewModel]
    
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
        self.player.$headArmor.sink(receiveValue: { _ in
            self.maxArmorPoints = self.player.getMaxArmorPoints()
        }).store(in: &self.subscriptions)
        self.player.$bodyArmor.sink(receiveValue: { _ in
            self.maxArmorPoints = self.player.getMaxArmorPoints()
        }).store(in: &self.subscriptions)
        self.player.$legsArmor.sink(receiveValue: { _ in
            self.maxArmorPoints = self.player.getMaxArmorPoints()
        }).store(in: &self.subscriptions)
        
        self.player.$gold.sink(receiveValue: { newValue in
            self.gold = newValue
        }).store(in: &self.subscriptions)
        
        self.player.$location.sink(receiveValue: { newValue in
            self.locationViewModel = LocationViewModel(newValue)
        }).store(in: &self.subscriptions)
        
        self.player.$weapons.sink(receiveValue: { newValue in
            self.weaponViewModels = newValue.map { WeaponViewModel($0) }
        }).store(in: &self.subscriptions)
    }
    
    func equipArmor(_ armor: ArmorAbstract) {
        self.player.equipArmor(armor)
    }
    
    func travel(to locationViewModel: LocationViewModel) {
        self.player.travel(to: locationViewModel.location)
    }
    
}

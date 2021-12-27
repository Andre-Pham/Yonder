//
//  PlayerPresenter.swift
//  yonder
//
//  Created by Andre Pham on 11/12/21.
//

import Foundation
import Combine

class PlayerPresenter: ObservableObject {
    
    private(set) var player: Player
    private var subscriptions: Set<AnyCancellable> = []
    
    @Published private(set) var health: Int
    @Published private(set) var maxHealth: Int
    @Published private(set) var armorPoints: Int
    @Published private(set) var maxArmorPoints: Int
    @Published private(set) var gold: Int
    
    private(set) var locationPresenter: LocationPresenter
    
    init(_ player: Player) {
        self.player = player
        
        // MARK: Set properties to match Player
        
        self.health = self.player.health
        self.maxHealth = self.player.maxHealth
        self.armorPoints = self.player.armorPoints
        self.maxArmorPoints = self.player.getMaxArmorPoints()
        self.gold = self.player.gold
        
        // MARK: Set other presenters
        
        self.locationPresenter = LocationPresenter(self.player.location, player: self.player)
        
        // MARK: Add Subscribers
        
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
    }
    
    func equipArmor(_ armor: ArmorAbstract) {
        self.player.equipArmor(armor)
    }
    
}

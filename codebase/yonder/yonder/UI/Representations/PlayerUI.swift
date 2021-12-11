//
//  PlayerUI.swift
//  yonder
//
//  Created by Andre Pham on 11/12/21.
//

import Foundation

class PlayerUI: ObservableObject {
    
    private(set) var player: Player
    
    @Published private(set) var health: Int
    @Published private(set) var maxHealth: Int
    @Published private(set) var armorPoints: Int
    @Published private(set) var maxArmorPoints: Int
    @Published private(set) var gold: Int
    
    init(_ player: Player) {
        self.player = player
        self.health = self.player.health
        self.maxHealth = self.player.maxHealth
        self.armorPoints = self.player.armorPoints
        self.maxArmorPoints = self.player.getMaxArmorPoints()
        self.gold = self.player.gold
    }
    
    func refresh() {
        self.health = self.player.health
        self.maxHealth = self.player.maxHealth
        self.armorPoints = self.player.armorPoints
        self.maxArmorPoints = self.player.getMaxArmorPoints()
        self.gold = self.player.gold
    }
    
    func equipArmor(_ armor: ArmorAbstract) {
        self.player.equipArmor(armor)
        self.refresh()
    }
    
}

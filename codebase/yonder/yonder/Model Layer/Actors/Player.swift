//
//  Player.swift
//  yonder
//
//  Created by Andre Pham on 17/11/21.
//

import Foundation

class Player: ActorAbstract {
    
    @DidSetPublished private(set) var location: Location
    @DidSetPublished private(set) var gold = 0 {
        didSet {
            OnGoldChangePublisher.publish(player: self)
        }
    }
    private(set) var attributes = [PlayerAttribute]()
    @DidSetPublished private(set) var loot: LootBag? = nil
    
    init(maxHealth: Int, location: Location) {
        self.location = location
        location.setToVisited(from: NoLocation())
        
        super.init(maxHealth: maxHealth)
    }
    
    func setGold(to amount: Int) {
        self.gold = max(amount, 0)
    }
    
    func modifyGold(by amount: Int) {
        self.gold = max(self.gold + amount, 0)
    }
    
    func modifyGoldAdjusted(by amount: Int) {
        if amount < 0 {
            self.modifyGold(by: BuffApps.getAdjustedPrice(purchaser: self, price: amount))
        }
        else if amount > 0 {
            self.modifyGold(by: BuffApps.getAdjustedGoldWithBonus(receiver: self, gold: amount))
        }
    }
    
    func travel(to location: Location) {
        OnPlayerTravelPublisher.publish(player: self, newLocation: location)
        
        location.setToVisited(from: self.location)
        self.location = location
        
        AfterPlayerTravelPublisher.publish(player: self)
    }
    
    func clearAttributes() {
        self.attributes.removeAll()
    }
    
    func addAttribute(_ attribute: PlayerAttribute) {
        self.attributes.append(attribute)
    }
    
    /// Retrieves the weapons the player can actually attack with.
    /// Provides the player with a default weapon if they are out of weapons or banned from attacking with weapons so the game can't reach a stalemate.
    /// - Returns: Weapons the player is permitted to attack with
    func getApplicableWeapons() -> [Weapon] {
        if self.weapons.isEmpty || self.attributes.contains(.cantAttack) {
            return [DefaultPlayerWeapon()]
        }
        return Array(self.weapons)
    }
    
    func canAfford(price: Int) -> Bool {
        let adjustedPrice = BuffApps.getAdjustedPrice(purchaser: self, price: price)
        return adjustedPrice <= self.gold
    }
    
    func getIndicativePrice(from price: Int) -> Int {
        return BuffApps.getAdjustedPrice(purchaser: self, price: price)
    }
    
    func getIndicativePayout(from amount: Int) -> Int {
        return BuffApps.getAdjustedGoldWithBonus(receiver: self, gold: amount)
    }
    
    func setLoot(to loot: LootBag?) {
        self.loot = loot
    }
    
}

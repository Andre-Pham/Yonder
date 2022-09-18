//
//  GoblinEffectPill.swift
//  yonder
//
//  Created by Andre Pham on 17/9/2022.
//

import Foundation

class GoblinEffectPill: WeaponEffectPill, OnGoldChangeSubscriber {
    
    private let goldPerSteal: Int
    private let damage: Int
    public let effectsDescription: String
    
    init(goldPerSteal: Int, damage: Int) {
        self.goldPerSteal = goldPerSteal
        self.damage = damage
        self.effectsDescription = Strings.WeaponEffectPill.Goblin.Description2Param.localWithArgs(self.goldPerSteal, self.damage)
        super.init()
        
        OnGoldChangePublisher.subscribe(self)
    }
    
    required init(_ original: WeaponEffectPillAbstract) {
        let original = original as! Self
        self.goldPerSteal = original.goldPerSteal
        self.damage = original.damage
        self.effectsDescription = original.effectsDescription
        super.init(original)
        
        OnGoldChangePublisher.subscribe(self)
    }
    
    func apply(owner: ActorAbstract, opposition: ActorAbstract) {
        if let player = opposition as? Player {
            if player.gold > 0 {
                player.modifyGoldAdjusted(by: -self.goldPerSteal)
            }
        } else {
            assertionFailure("GoblinEffectPill is being used on a non-player, and only players have gold to steal")
        }
    }
    
    func onGoldChange(player: Player) {
        if let weapon = WeaponPillBox.getWeapon(from: self) {
            if player.gold > 0 {
                weapon.setDamage(to: 0)
            } else {
                weapon.setDamage(to: self.damage)
            }
        }
    }
    
    func getValue() -> Int {
        return (self.damage + self.goldPerSteal)/2
    }
    
}

//
//  GoblinEffectPill.swift
//  yonder
//
//  Created by Andre Pham on 17/9/2022.
//

import Foundation

class GoblinEffectPill: WeaponEffectPill {
    
    private let goldPerSteal: Int
    private let damage: Int
    public let effectsDescription: String
    
    init(goldPerSteal: Int, damage: Int) {
        self.goldPerSteal = goldPerSteal
        self.damage = damage
        self.effectsDescription = Strings.WeaponEffectPill.Goblin.Description2Param.localWithArgs(self.goldPerSteal, self.damage)
        super.init()
    }
    
    required init(_ original: WeaponEffectPillAbstract) {
        let original = original as! Self
        self.goldPerSteal = original.goldPerSteal
        self.damage = original.damage
        self.effectsDescription = original.effectsDescription
        super.init(original)
    }
    
    func apply(owner: ActorAbstract, opposition: ActorAbstract) {
        if let player = opposition as? Player {
            if player.gold > 0 {
                player.modifyGoldAdjusted(by: -self.goldPerSteal)
            } else {
                guard let weapon = owner.weapons.first(where: { $0.hasEffectPill(self) }) else {
                    assertionFailure("Actor is using a weapon they don't own")
                    return
                }
                player.delayedDamageValues.addDamageAdjusted(sourceOwner: owner, using: weapon, target: player, for: self.damage)
            }
        } else {
            assertionFailure("GoblinEffectPill is being used on a non-player, and only players have gold to steal")
        }
    }
    
    func getValue() -> Int {
        return (self.damage + self.goldPerSteal)/2
    }
    
}

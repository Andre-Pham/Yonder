//
//  CopyAttackEffectPill.swift
//  yonder
//
//  Created by Andre Pham on 18/9/2022.
//

import Foundation

class CopyAttackEffectPill: WeaponEffectPill, AfterTurnEndSubscriber {
    
    public let effectsDescription: String
    
    override init() {
        self.effectsDescription = Strings.WeaponEffectPill.CopyAttack.Description.local
        super.init()
        
        AfterTurnEndPublisher.subscribe(self)
    }
    
    required init(_ original: WeaponEffectPillAbstract) {
        let original = original as! Self
        self.effectsDescription = original.effectsDescription
        super.init(original)
        
        AfterTurnEndPublisher.subscribe(self)
    }
    
    func apply(owner: ActorAbstract, opposition: ActorAbstract) {
        // No nothing
    }
    
    func afterTurnEnd(player: Player, playerUsed: Item?, foe: Foe?) {
        if let weapon = playerUsed as? Weapon, let foe = foe {
            if weapon.damage > 0 && weapon.hasEffectPill(self) && foe.isDead {
                weapon.setDamage(to: foe.getWeapon().damage)
            }
        }
    }
    
    func getValue() -> Int {
        return 50
    }
    
}
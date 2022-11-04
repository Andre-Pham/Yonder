//
//  LifestealEffectPill.swift
//  yonder
//
//  Created by Andre Pham on 4/11/2022.
//

import Foundation

class LifestealEffectPill: WeaponEffectPill {
    
    public let effectsDescription: String
    private let lifestealFraction: Double
    
    init(lifestealFraction: Double) {
        self.effectsDescription = Strings("weaponEffectPill.lifesteal.description1Param").localWithArgs((lifestealFraction*100.0).toString())
        self.lifestealFraction = lifestealFraction
        super.init()
    }
    
    required init(_ original: WeaponEffectPillAbstract) {
        let original = original as! Self
        self.effectsDescription = original.effectsDescription
        self.lifestealFraction = original.lifestealFraction
        super.init(original)
    }
    
    func apply(owner: ActorAbstract, opposition: ActorAbstract) {
        guard let weapon = WeaponPillBox.getWeapon(from: self) else {
            assertionFailure("LifestealEffectPill has no matching weapon")
            return
        }
        let damageDealt = owner.getIndicativeDamage(of: weapon, opposition: opposition)
        let healthToRestore = (Double(damageDealt)*self.lifestealFraction).toRoundedInt()
        owner.delayedRestorationValues.addRestorationAdjusted(type: .health, sourceOwner: owner, using: weapon, for: healthToRestore)
    }
    
    func calculateBasePurchasePrice() -> Int {
        Pricing.playerHealthRestorationStat.getValue(
            amount: Pricing.playerDamageStat.fractionOfBaseStatAmount(self.lifestealFraction),
            uses: 5
        )
    }
    
}

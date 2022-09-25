//
//  ArmorDamagePercentBuffPill.swift
//  yonder
//
//  Created by Andre Pham on 19/9/2022.
//

import Foundation

class ArmorDamagePercentBuffPill: WeaponBuffPill {
    
    private let damageFraction: Double
    public let effectsDescription: String
    
    init(damageFraction: Double) {
        self.damageFraction = damageFraction
        if self.damageFraction.truncatingRemainder(dividingBy: 1.0) == 0.0 {
            let multiplier = Int(damageFraction)
            self.effectsDescription = Strings.WeaponBuffPill.ArmorDamagePercent.DescriptionMultiplier1Param.localWithArgs(multiplier)
        } else {
            let percentage = self.damageFraction.toRelativePercentage()
            self.effectsDescription = (damageFraction > 1.0 ?
                Strings.WeaponBuffPill.ArmorDamagePercent.IncreaseDescription1Param.localWithArgs(percentage) :
                Strings.WeaponBuffPill.ArmorDamagePercent.DecreaseDescription1Param.localWithArgs(percentage))
        }
        super.init()
    }
    
    required init(_ original: WeaponBuffPillAbstract) {
        let original = original as! Self
        self.damageFraction = original.damageFraction
        self.effectsDescription = original.effectsDescription
        super.init(original)
    }
    
    override func applyDamage(weapon: Weapon, owner: ActorAbstract, opposition: ActorAbstract) -> Int {
        let evening = opposition.armorPoints%2 == 0 ? 0 : 1
        let damageBonusRequiredToRemoveArmorPoints = (opposition.armorPoints - evening)/2
        if damageBonusRequiredToRemoveArmorPoints >= weapon.damage {
            return weapon.damage*2
        } else {
            let damageForArmor = damageBonusRequiredToRemoveArmorPoints*2
            let damageForHealth = weapon.damage - damageBonusRequiredToRemoveArmorPoints
            return damageForArmor + damageForHealth
        }
    }
    
    func getValue() -> Int {
        return 250
    }
    
}

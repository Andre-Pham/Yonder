//
//  ArmorDamagePercentBuffPill.swift
//  yonder
//
//  Created by Andre Pham on 19/9/2022.
//

import Foundation

/// "Does X% more damage to armor"
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
    
    func calculateBasePurchasePrice() -> Int {
        let timeRemaining: Int?
        if let weapon = WeaponPillBox.getWeapon(from: self) {
            if weapon.infiniteRemainingUses {
                timeRemaining = nil
            } else {
                timeRemaining = weapon.remainingUses
            }
        } else {
            assertionFailure("Buff pill belongs to no weapon")
            timeRemaining = nil
        }
        return Pricing.getTargetedBuffValue(
            fraction: self.damageFraction,
            defaultTargetsOwner: false,
            target: .foe,
            playerStat: Pricing.playerDamageStat,
            foeStat: Pricing.foeDamageStat,
            timeRemaining: timeRemaining,
            direction: .outgoing
        )*Pricing.foeArmorPointsStat.baseStatAmount/(Pricing.foeArmorPointsStat.baseStatAmount + Pricing.foeHealthStat.baseStatAmount)
    }
    
}

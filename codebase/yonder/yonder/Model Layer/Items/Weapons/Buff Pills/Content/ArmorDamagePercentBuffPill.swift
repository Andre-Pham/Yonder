//
//  ArmorDamagePercentBuffPill.swift
//  yonder
//
//  Created by Andre Pham on 19/9/2022.
//

import Foundation

/// "Does X% more damage to armor"
class ArmorDamagePercentBuffPill: WeaponBuffPill {
    
    public let damageFraction: Double
    public let effectsDescription: String
    
    init(damageFraction: Double) {
        self.damageFraction = damageFraction
        if isZero(self.damageFraction.truncatingRemainder(dividingBy: 1.0)) {
            let multiplier = Int(damageFraction)
            self.effectsDescription = Strings("weaponBuffPill.armorDamagePercent.descriptionMultiplier1Param").localWithArgs(multiplier)
        } else {
            let percentage = self.damageFraction.toRelativePercentage()
            self.effectsDescription = (damageFraction > 1.0 ?
                Strings("weaponBuffPill.armorDamagePercent.increaseDescription1Param").localWithArgs(percentage) :
                Strings("weaponBuffPill.armorDamagePercent.decreaseDescription1Param").localWithArgs(percentage))
        }
        super.init()
    }
    
    required init(_ original: WeaponBuffPillAbstract) {
        let original = original as! Self
        self.damageFraction = original.damageFraction
        self.effectsDescription = original.effectsDescription
        super.init(original)
    }
    
    // MARK: - Serialisation
    
    private enum Field: String {
        case damageFraction
        case effectsDescription
    }
    
    required init(dataObject: DataObject) {
        self.damageFraction = dataObject.get(Field.damageFraction.rawValue)
        self.effectsDescription = dataObject.get(Field.effectsDescription.rawValue)
        super.init(dataObject: dataObject)
    }
    
    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.damageFraction.rawValue, value: self.damageFraction)
            .add(key: Field.effectsDescription.rawValue, value: self.effectsDescription)
    }
    
    // MARK: - Functions
    
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

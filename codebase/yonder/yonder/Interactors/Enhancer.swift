//
//  Enhancer.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

enum UpgradeOptions {
    case weaponDamage
    case weaponDurability
    case armorPoints
    // TODO: Eventually add upgrades available for weapons to give buffs and status effects
    // E.g. give a weapon a burn effect
    // Do the same for armor
}

class Enhancer: InteractorAbstract {
    
    public let options: [UpgradeOptions]
    
    init(options: [UpgradeOptions]) {
        self.options = options
    }
    
    func upgradeWeaponDamage(weapon: WeaponAbstract, by damage: Int, purchaser: Player, price: Int) {
        let adjustedPrice = BuffApps.getAdjustedPrice(purchaser: purchaser, price: price)
        if purchaser.gold < adjustedPrice {
            return
        }
        weapon.adjustDamage(by: damage)
    }
    
    func upgradeWeaponDurability(weapon: WeaponAbstract, by durability: Int, purchaser: Player, price: Int) {
        let adjustedPrice = BuffApps.getAdjustedPrice(purchaser: purchaser, price: price)
        if purchaser.gold < adjustedPrice {
            return
        }
        weapon.adjustRemainingUses(by: durability)
    }
    
    func upgradeArmorPoints(armor: ArmorAbstract, by armorPoints: Int, purchaser: Player, price: Int) {
        let adjustedPrice = BuffApps.getAdjustedPrice(purchaser: purchaser, price: price)
        if purchaser.gold < adjustedPrice {
            return
        }
        armor.adjustArmorPoints(by: armorPoints)
    }
}

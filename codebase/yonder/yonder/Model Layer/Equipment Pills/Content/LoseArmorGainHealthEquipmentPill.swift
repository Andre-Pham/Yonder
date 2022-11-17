//
//  LoseArmorGainHealthEquipmentPill.swift
//  yonder
//
//  Created by Andre Pham on 17/11/2022.
//

import Foundation

class LoseArmorGainHealthEquipmentPill: EquipmentPill, OnCombatTurnEndSubscriber {
    
    private let restorationFraction: Double
    private var startingPlayerArmorPoints: Int = 0
    private var startingFoeArmorPoints: Int = 0
    
    init(restorationFraction: Double, sourceName: String) {
        self.restorationFraction = restorationFraction
        
        super.init(
            sourceName: sourceName,
            effectsDescription: Strings("equipmentPill.loseArmorGainHealth.effectsDescription1Param").localWithArgs((restorationFraction*100.0).toString())
        )
        
        OnCombatTurnEndPublisher.subscribe(self)
    }
    
    required init(_ original: EquipmentPillAbstract) {
        let original = original as! Self
        self.restorationFraction = original.restorationFraction
        
        super.init(original)
        
        OnCombatTurnEndPublisher.subscribe(self)
    }
    
    func onCombatTurnEnd(player: Player, playerUsed: Item, foe: Foe) {
        if player.hasEquipmentEffect(self) {
            let damage = player.delayedDamageValues.totalStoredDamage
            let amount = min(damage, player.armorPoints)
            player.delayedRestorationValues.addRestorationAdjusted(type: .health, sourceOwner: player, using: self, for: amount)
        } else if foe.hasEquipmentEffect(self) {
            let damage = foe.delayedDamageValues.totalStoredDamage
            let amount = min(damage, foe.armorPoints)
            foe.delayedRestorationValues.addRestorationAdjusted(type: .health, sourceOwner: foe, using: self, for: amount)
        }
    }
    
    func getValue(whenTargeting target: Target) -> Int {
        switch target {
        case .player:
            return Pricing.playerHealthRestorationStat.getValue(amount: Pricing.playerArmorPointsStat.fractionOfBaseStatAmount(self.restorationFraction), uses: Pricing.Stat.infiniteDuration)
        case .foe:
            return Pricing.foeHealthRestorationStat.getValue(amount: Pricing.foeArmorPointsStat.fractionOfBaseStatAmount(self.restorationFraction), uses: Pricing.Stat.infiniteDuration)
        }
    }
    
}

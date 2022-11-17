//
//  PermanentHealthAfterKillEquipmentPill.swift
//  yonder
//
//  Created by Andre Pham on 17/11/2022.
//

import Foundation

class PermanentHealthAfterKillEquipmentPill: EquipmentPill, AfterCombatTurnEndSubscriber {
    
    private let maxHealthFraction: Double
    
    init(maxHealthFraction: Double, sourceName: String) {
        self.maxHealthFraction = maxHealthFraction
        
        super.init(
            sourceName: sourceName,
            effectsDescription: Strings("equipmentPill.permanentHealthAfterKill.effectsDescription1Param").localWithArgs((maxHealthFraction*100.0).toString())
        )
        
        AfterCombatTurnEndPublisher.subscribe(self)
    }
    
    required init(_ original: EquipmentPillAbstract) {
        let original = original as! Self
        self.maxHealthFraction = original.maxHealthFraction
        super.init(original)
        
        AfterCombatTurnEndPublisher.subscribe(self)
    }
    
    func afterCombatTurnEnd(player: Player, playerUsed: Item, foe: Foe) {
        if player.hasEquipmentEffect(self) && foe.isDead {
            let bonus = (Double(foe.maxHealth)*self.maxHealthFraction).toRoundedInt()
            player.adjustBonusHealth(by: bonus)
        }
        // If a foe has this, its effect is redundant because the player dies
    }
    
    func getValue(whenTargeting target: Target) -> Int {
        switch target {
        case .player:
            return Pricing.playerPermanentHealthStat.getValue(amount: Pricing.foeHealthStat.fractionOfBaseStatAmount(self.maxHealthFraction), uses: Pricing.Stat.infiniteDuration)
        case .foe:
            return 0
            // If a foe has this, its effect is redundant because the player dies
        }
    }
    
}

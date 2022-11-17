//
//  RestoreAfterKillEquipmentPill.swift
//  yonder
//
//  Created by Andre Pham on 17/11/2022.
//

import Foundation

class RestoreAfterKillEquipmentPill: EquipmentPill, AfterCombatTurnEndSubscriber {
    
    private let healthRestoration: Int
    private let armorPointsRestoration: Int
    
    init(healthRestoration: Int, armorPointsRestoration: Int, sourceName: String) {
        self.healthRestoration = healthRestoration
        self.armorPointsRestoration = armorPointsRestoration
        
        let effectsDescription: String
        if healthRestoration == 0 && armorPointsRestoration > 0 {
            effectsDescription = Strings("equipmentPill.restoreAfterKill.armorPoints.effectsDescription1Param").localWithArgs(armorPointsRestoration)
        } else if healthRestoration > 0 && armorPointsRestoration == 0 {
            effectsDescription = Strings("equipmentPill.restoreAfterKill.health.effectsDescription1Param").localWithArgs(healthRestoration)
        } else if healthRestoration > 0 && armorPointsRestoration > 0 {
            effectsDescription = Strings("equipmentPill.restoreAfterKill.healthAndArmorPoints.effectsDescription2Param").localWithArgs(healthRestoration, armorPointsRestoration)
        } else {
            effectsDescription = ""
            assertionFailure("Accessory has invalid params, both params must be >= 0 and one must be > 0.")
        }
        super.init(
            sourceName: sourceName,
            effectsDescription: effectsDescription
        )
        
        AfterCombatTurnEndPublisher.subscribe(self)
    }
    
    required init(_ original: EquipmentPillAbstract) {
        let original = original as! Self
        self.healthRestoration = original.healthRestoration
        self.armorPointsRestoration = original.armorPointsRestoration
        super.init(original)
        
        AfterCombatTurnEndPublisher.subscribe(self)
    }
    
    func afterCombatTurnEnd(player: Player, playerUsed: Item, foe: Foe) {
        if player.hasEquipmentEffect(self) && foe.isDead {
            if self.healthRestoration > 0 {
                player.restoreHealthAdjusted(sourceOwner: player, using: self, for: self.healthRestoration)
            }
            if self.armorPointsRestoration > 0 {
                player.restoreArmorPointsAdjusted(sourceOwner: player, using: self, for: self.armorPointsRestoration)
            }
        }
        // If a foe has this, its effect is redundant because the player dies
    }
    
    func getValue(whenTargeting target: Target) -> Int {
        switch target {
        case .player:
            return Pricing.playerHealthRestorationStat.getValue(amount: self.healthRestoration, uses: Pricing.Stat.infiniteDuration) + Pricing.playerArmorPointsRestorationStat.getValue(amount: self.armorPointsRestoration, uses: Pricing.Stat.infiniteDuration)
        case .foe:
            return 0
            // If a foe has this, its effect is redundant because the player dies
        }
    }
    
}


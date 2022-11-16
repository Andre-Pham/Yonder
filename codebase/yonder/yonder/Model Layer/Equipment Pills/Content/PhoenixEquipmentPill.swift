//
//  PhoenixEquipmentPill.swift
//  yonder
//
//  Created by Andre Pham on 17/9/2022.
//

import Foundation

class PhoenixEquipmentPill: EquipmentPill, AfterTurnEndSubscriber {
    
    private let healthSetTo: Int?
    
    init(healthSetTo: Int?, sourceName: String) {
        self.healthSetTo = healthSetTo
        
        let effectsDescription = (
            healthSetTo == nil ?
            Strings("equipmentPill.phoenix.max.effectsDescription").local :
            Strings("equipmentPill.phoenix.partial.effectsDescription1Param").localWithArgs(healthSetTo!)
        )
        super.init(
            sourceName: sourceName,
            effectsDescription: effectsDescription
        )
        
        AfterTurnEndPublisher.subscribe(self)
    }
    
    required init(_ original: EquipmentPillAbstract) {
        let original = original as! Self
        super.init(original)
        
        AfterTurnEndPublisher.subscribe(self)
    }
    
    func getValue(whenTargeting target: Target) -> Int {
        switch target {
        case .player:
            return 200 + Pricing.playerHealthRestorationStat.getValue(amount: self.healthSetTo ?? Pricing.playerHealthStat.baseStatAmount)
        case .foe:
            return 200 + Pricing.foeHealthRestorationStat.getValue(amount: self.healthSetTo ?? Pricing.foeHealthStat.baseStatAmount)
        }
    }
    
    func afterTurnEnd(player: Player, playerUsed: Item?, foe: Foe?) {
        if player.isDead && player.hasEquipmentEffect(self) {
            player.setHealth(to: self.healthSetTo ?? player.maxHealth)
            player.unequipEquipmentEffect(self)
        }
    }
    
}

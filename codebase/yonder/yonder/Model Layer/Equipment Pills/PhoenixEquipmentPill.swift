//
//  PhoenixEquipmentPill.swift
//  yonder
//
//  Created by Andre Pham on 17/9/2022.
//

import Foundation

class PhoenixEquipmentPill: EquipmentPill, AfterTurnEndSubscriber {
    
    private let healthSetTo = 50
    
    init(sourceName: String) {
        super.init(
            sourceName: sourceName,
            effectsDescription: Strings.EquipmentPill.Phoenix.EffectsDescription1Param
                .localWithArgs(self.healthSetTo)
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
            return 200 + Pricing.playerHealthRestorationStat.getValue(amount: self.healthSetTo)
        case .foe:
            return 200 + Pricing.foeHealthRestorationStat.getValue(amount: self.healthSetTo)
        }
    }
    
    func afterTurnEnd(player: Player, playerUsed: Item?, foe: Foe?) {
        if player.isDead && player.hasEquipmentEffect(self) {
            player.setHealth(to: self.healthSetTo)
            player.unequipEquipmentEffect(self)
        }
    }
    
}

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
    
    func getValue() -> Int {
        return 200 + self.healthSetTo/2
    }
    
    func afterTurnEnd(player: Player, playerUsed: Item?, foe: Foe?) {
        if player.isDead && player.hasEquipmentEffect(self) {
            player.setHealth(to: self.healthSetTo)
            player.unequipEquipmentEffect(self)
        }
    }
    
}

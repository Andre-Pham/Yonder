//
//  ThornsEquipmentPill.swift
//  yonder
//
//  Created by Andre Pham on 28/8/2022.
//

import Foundation

class ThornsEquipmentPill: EquipmentPillAbstract, OnTurnEndSubscriber {
    
    private let thornsFraction: Double
    
    init(thornsFraction: Double, sourceName: String) {
        self.thornsFraction = thornsFraction
        
        super.init(
            sourceName: sourceName,
            effectsDescription: Strings.EquipmentPill.Thorns.EffectsDescription1Param
                .localWithArgs((thornsFraction*100.0).toString())
        )
        
        OnTurnEndPublisher.subscribe(self)
    }
    
    required init(_ original: EquipmentPillAbstractPart) {
        let original = original as! Self
        self.thornsFraction = original.thornsFraction
        
        super.init(original)
        
        OnTurnEndPublisher.subscribe(self)
    }
    
    func onTurnEnd(player: Player, playerUsed playerItem: ItemAbstract, foe: Foe) {
        if player.hasEquipmentEffect(self) {
            let damageTaken = foe.getIndicativeDamage(of: foe.getWeapon(), opposition: player)
            let damage = Int(round(Double(damageTaken)*self.thornsFraction))
            foe.delayedDamageValues.addDamageAdjusted(sourceOwner: player, using: self, for: damage)
        } else if foe.hasEquipmentEffect(self) {
            let damageTaken = player.getIndicativeDamage(of: playerItem, opposition: foe)
            let damage = Int(round(Double(damageTaken)*self.thornsFraction))
            player.delayedDamageValues.addDamageAdjusted(sourceOwner: foe, using: self, for: damage)
        }
    }
    
    func getValue() -> Int {
        return Int(round(self.thornsFraction*10.0))
    }
    
}

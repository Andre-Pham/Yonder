//
//  ThornsEquipmentPill.swift
//  yonder
//
//  Created by Andre Pham on 28/8/2022.
//

import Foundation

class ThornsEquipmentPill: EquipmentPill, OnTurnEndSubscriber {
    
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
    
    required init(_ original: EquipmentPillAbstract) {
        let original = original as! Self
        self.thornsFraction = original.thornsFraction
        
        super.init(original)
        
        OnTurnEndPublisher.subscribe(self)
    }
    
    func onTurnEnd(player: Player, playerUsed playerItem: Item?, foe: Foe?) {
        guard let playerItem = playerItem, let foe = foe else {
            return
        }
        if player.hasEquipmentEffect(self) {
            let damageTaken = foe.getIndicativeDamage(of: foe.getWeapon(), opposition: player)
            let damage = Int(round(Double(damageTaken)*self.thornsFraction))
            foe.delayedDamageValues.addDamageAdjusted(sourceOwner: player, using: self, target: foe, for: damage)
        } else if foe.hasEquipmentEffect(self) {
            let damageTaken = player.getIndicativeDamage(of: playerItem, opposition: foe)
            let damage = Int(round(Double(damageTaken)*self.thornsFraction))
            player.delayedDamageValues.addDamageAdjusted(sourceOwner: foe, using: self, target: player, for: damage)
        }
    }
    
    func getValue(whenTargeting target: Target) -> Int {
        return Pricing.getBuffValue(
            flipIncomingOutgoing: target == .foe,
            incomingStat: Pricing.playerDamageStat,
            outgoingStat: Pricing.foeDamageStat,
            fraction: self.thornsFraction,
            duration: nil,
            direction: .outgoing
        )
    }
    
}

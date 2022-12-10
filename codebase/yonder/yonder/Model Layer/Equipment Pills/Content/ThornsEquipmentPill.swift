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
            effectsDescription: Strings("equipmentPill.thorns.effectsDescription1Param").localWithArgs((thornsFraction*100.0).toString())
        )
        
        OnTurnEndPublisher.subscribe(self)
    }
    
    required init(_ original: EquipmentPillAbstract) {
        let original = original as! Self
        self.thornsFraction = original.thornsFraction
        
        super.init(original)
        
        OnTurnEndPublisher.subscribe(self)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case thornsFraction
    }

    required init(dataObject: DataObject) {
        self.thornsFraction = dataObject.get(Field.thornsFraction.rawValue)
        super.init(dataObject: dataObject)
        
        OnTurnEndPublisher.subscribe(self)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.thornsFraction.rawValue, value: self.thornsFraction)
    }

    // MARK: - Functions
    
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
        switch target {
        case .player:
            return Pricing.playerDamageStat.getValue(amount: Pricing.foeDamageStat.fractionOfBaseStatAmount(self.thornsFraction), uses: Pricing.Stat.infiniteDuration)
        case .foe:
            return Pricing.foeDamageStat.getValue(amount: Pricing.playerDamageStat.fractionOfBaseStatAmount(self.thornsFraction), uses: Pricing.Stat.infiniteDuration)
        }
    }
    
}

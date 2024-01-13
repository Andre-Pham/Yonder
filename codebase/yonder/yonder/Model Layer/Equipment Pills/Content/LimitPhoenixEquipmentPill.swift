//
//  LimitPhoenixEquipmentPill.swift
//  yonder
//
//  Created by Andre Pham on 13/1/2024.
//

import Foundation

class LimitPhoenixEquipmentPill: EquipmentPill, AfterTurnEndSubscriber {
    
    private let healthFraction: Double
    
    init(healthFraction: Double, sourceName: String) {
        assert(healthFraction < 1.0, "The owner shouldn't restore health every death")
        self.healthFraction = healthFraction
        
        super.init(
            sourceName: sourceName,
            effectsDescription: Strings("equipmentPill.limitPhoenix.effectsDescription1Param").localWithArgs((self.healthFraction*100.0).toString())
        )
        
        AfterTurnEndPublisher.subscribe(self)
    }
    
    required init(_ original: EquipmentPillAbstract) {
        let original = original as! Self
        self.healthFraction = original.healthFraction
        super.init(original)
        
        AfterTurnEndPublisher.subscribe(self)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case healthFraction
    }

    required init(dataObject: DataObject) {
        self.healthFraction = dataObject.get(Field.healthFraction.rawValue)
        super.init(dataObject: dataObject)
        
        AfterTurnEndPublisher.subscribe(self)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.healthFraction.rawValue, value: self.healthFraction)
    }

    // MARK: - Functions
    
    func getValue(whenTargeting target: Target) -> Int {
        // Base price of 500 because reviving is really strong - the net damage you're negating is much more than just what's being restored
        switch target {
        case .player:
            return 500 + Pricing.playerHealthRestorationStat.getValue(amount: (Double(Pricing.playerHealthStat.baseStatAmount)*self.healthFraction*2.0).toRoundedInt())
        case .foe:
            return 500 + Pricing.foeHealthRestorationStat.getValue(amount: (Double(Pricing.foeHealthStat.baseStatAmount)*self.healthFraction*2.0).toRoundedInt())
        }
    }
    
    func afterTurnEnd(player: Player, playerUsed: Item?, foe: Foe?) {
        if player.isDead && player.hasEquipmentEffect(self) {
            let healthSetTo = floor(Double(player.maxHealth)*self.healthFraction).toRoundedInt()
            assert(healthSetTo < player.maxHealth, "After every death, the owner should reduce in health")
            player.setMaxHealth(to: healthSetTo)
            player.setHealth(to: healthSetTo)
        } else if let foe, foe.isDead, foe.hasEquipmentEffect(self) {
            let healthSetTo = floor(Double(foe.maxHealth)*self.healthFraction).toRoundedInt()
            assert(healthSetTo < foe.maxHealth, "After every death, the owner should reduce in health")
            foe.setMaxHealth(to: healthSetTo)
            foe.setHealth(to: healthSetTo)
        }
    }
    
}

//
//  PhoenixEquipmentPill.swift
//  yonder
//
//  Created by Andre Pham on 17/9/2022.
//

import Foundation

/// Upon death, revive with a set amount of health to be restored to, then un-equip this.
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
        self.healthSetTo = original.healthSetTo
        super.init(original)
        
        AfterTurnEndPublisher.subscribe(self)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case healthSetTo
    }

    required init(dataObject: DataObject) {
        self.healthSetTo = dataObject.get(Field.healthSetTo.rawValue)
        super.init(dataObject: dataObject)
        
        AfterTurnEndPublisher.subscribe(self)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.healthSetTo.rawValue, value: self.healthSetTo)
    }

    // MARK: - Functions
    
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
        } else if let foe, foe.isDead, foe.hasEquipmentEffect(self) {
            foe.setHealth(to: self.healthSetTo ?? foe.maxHealth)
            foe.unequipEquipmentEffect(self)
        }
    }
    
}

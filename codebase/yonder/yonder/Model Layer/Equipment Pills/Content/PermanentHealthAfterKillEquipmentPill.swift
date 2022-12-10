//
//  PermanentHealthAfterKillEquipmentPill.swift
//  yonder
//
//  Created by Andre Pham on 17/11/2022.
//

import Foundation

class PermanentHealthAfterKillEquipmentPill: EquipmentPill, AfterPlayerKillFoeSubscriber {
    
    private let maxHealthFraction: Double
    
    init(maxHealthFraction: Double, sourceName: String) {
        self.maxHealthFraction = maxHealthFraction
        
        super.init(
            sourceName: sourceName,
            effectsDescription: Strings("equipmentPill.permanentHealthAfterKill.effectsDescription1Param").localWithArgs((maxHealthFraction*100.0).toString())
        )
        
        AfterPlayerKillFoePublisher.subscribe(self)
    }
    
    required init(_ original: EquipmentPillAbstract) {
        let original = original as! Self
        self.maxHealthFraction = original.maxHealthFraction
        super.init(original)
        
        AfterPlayerKillFoePublisher.subscribe(self)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case maxHealthFraction
    }

    required init(dataObject: DataObject) {
        self.maxHealthFraction = dataObject.get(Field.maxHealthFraction.rawValue)
        super.init(dataObject: dataObject)
        
        AfterPlayerKillFoePublisher.subscribe(self)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.maxHealthFraction.rawValue, value: self.maxHealthFraction)
    }

    // MARK: - Functions
    
    func afterPlayerKillFoe(player: Player, foe: Foe) {
        assert(foe.isDead, "Event indicating that a foe died has failed - foe remains alive")
        if player.hasEquipmentEffect(self) {
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

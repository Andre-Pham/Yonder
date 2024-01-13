//
//  LimitStatsFoePhoenixEquipmentPill.swift
//  yonder
//
//  Created by Andre Pham on 14/1/2024.
//

import Foundation

/// Fully revives the owner upon death with a fraction of their max health and attack.
/// TO ONLY BE EQUIPPED BY FOES - players don't have a "base attack" and hence can't have their max attack affected.
class LimitStatsFoePhoenixEquipmentPill: EquipmentPill, AfterTurnEndSubscriber {
    
    private let statsFraction: Double
    
    init(statsFraction: Double, sourceName: String) {
        assert(statsFraction < 1.0, "The owner shouldn't restore health every death")
        self.statsFraction = statsFraction
        
        super.init(
            sourceName: sourceName,
            // Technically, the effects description is completely unnecessary because the player will never equip this
            // We include it just for consistencies sake
            effectsDescription: Strings("equipmentPill.limitStatsFoePhoenixEquipmentPill.effectsDescription1Param").localWithArgs((self.statsFraction*100.0).toString())
        )
        
        AfterTurnEndPublisher.subscribe(self)
    }
    
    required init(_ original: EquipmentPillAbstract) {
        let original = original as! Self
        self.statsFraction = original.statsFraction
        super.init(original)
        
        AfterTurnEndPublisher.subscribe(self)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case statsFraction
    }

    required init(dataObject: DataObject) {
        self.statsFraction = dataObject.get(Field.statsFraction.rawValue)
        super.init(dataObject: dataObject)
        
        AfterTurnEndPublisher.subscribe(self)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.statsFraction.rawValue, value: self.statsFraction)
    }

    // MARK: - Functions
    
    func getValue(whenTargeting target: Target) -> Int {
        switch target {
        case .player:
            // The player can't equip this
            return 0
        case .foe:
            // Base price of 350 because reviving is really strong - the net damage you're negating is much more than just what's being restored
            return 350 + Pricing.foeHealthRestorationStat.getValue(amount: (Double(Pricing.foeHealthStat.baseStatAmount)*self.statsFraction*2.0).toRoundedInt())
        }
    }
    
    func afterTurnEnd(player: Player, playerUsed: Item?, foe: Foe?) {
        if player.hasEquipmentEffect(self) {
            assertionFailure("The player shouldn't be able to equip this")
        } else if let foe, foe.isDead, foe.hasEquipmentEffect(self) {
            let healthSetTo = floor(Double(foe.maxHealth)*self.statsFraction).toRoundedInt()
            assert(healthSetTo < foe.maxHealth, "After every death, the owner should reduce in health")
            foe.setMaxHealth(to: healthSetTo)
            foe.setHealth(to: healthSetTo)
            let attackSetTo = floor(Double(foe.getWeapon().damage)*self.statsFraction).toRoundedInt()
            assert(attackSetTo < foe.getWeapon().damage, "After every death, the owner should reduce in attack")
            foe.getWeapon().setDamage(to: attackSetTo)
        }
    }
    
}

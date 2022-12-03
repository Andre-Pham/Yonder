//
//  WeaponLifestealEquipmentPill.swift
//  yonder
//
//  Created by Andre Pham on 22/7/2022.
//

import Foundation

class WeaponLifestealEquipmentPill: EquipmentPill, OnActorAttackSubscriber {
    
    private let lifestealFraction: Double
    
    init(lifestealFraction: Double, sourceName: String) {
        self.lifestealFraction = lifestealFraction
        
        super.init(
            sourceName: sourceName,
            effectsDescription: Strings("equipmentPill.weaponLifesteal.effectsDescription1Param").localWithArgs((lifestealFraction*100.0).toString())
        )
        
        OnActorAttackPublisher.subscribe(self)
    }
    
    required init(_ original: EquipmentPillAbstract) {
        let original = original as! Self
        self.lifestealFraction = original.lifestealFraction
        
        super.init(original)
        
        OnActorAttackPublisher.subscribe(self)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case lifestealFraction
    }

    required init(dataObject: DataObject) {
        self.lifestealFraction = dataObject.get(Field.lifestealFraction.rawValue)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.lifestealFraction.rawValue, value: self.lifestealFraction)
    }

    // MARK: - Functions
    
    func onActorAttack(actor: ActorAbstract, weapon: Weapon, target: ActorAbstract) {
        guard actor.hasEquipmentEffect(self) else {
            return
        }
        let damageDealt = actor.getIndicativeDamage(of: weapon, opposition: target)
        let healthToRestore = (Double(damageDealt)*self.lifestealFraction).toRoundedInt()
        actor.delayedRestorationValues.addRestorationAdjusted(type: .health, sourceOwner: actor, using: self, for: healthToRestore)
    }
    
    func getValue(whenTargeting target: Target) -> Int {
        switch target {
        case .player:
            return Pricing.playerHealthRestorationStat.getValue(amount: Pricing.playerDamageStat.fractionOfBaseStatAmount(self.lifestealFraction), uses: Pricing.Stat.infiniteDuration)
        case .foe:
            return Pricing.foeHealthRestorationStat.getValue(amount: Pricing.foeDamageStat.fractionOfBaseStatAmount(self.lifestealFraction), uses: Pricing.Stat.infiniteDuration)
        }
    }
    
}

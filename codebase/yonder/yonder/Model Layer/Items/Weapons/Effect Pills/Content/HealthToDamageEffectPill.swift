//
//  HealthToDamageEffectPill.swift
//  yonder
//
//  Created by Andre Pham on 17/1/2024.
//

import Foundation

class HealthToDamageEffectPill: WeaponEffectPill, AfterActorTakeDamageSubscriber {
    
    public let effectsDescription: String
    public let conversionFraction: Double
    
    init(conversionFraction: Double) {
        if isEqual(conversionFraction, 1.0) {
            self.effectsDescription = Strings("weaponEffectPill.healthToDamage.all.description").local
        } else {
            self.effectsDescription = Strings("weaponEffectPill.healthToDamage.fraction.description1Param").localWithArgs((conversionFraction*100.0).toString(decimalPlaces: 0))
        }
        self.conversionFraction = conversionFraction
        
        super.init()
        
        AfterActorTakeDamagePublisher.subscribe(self)
    }
    
    required init(_ original: WeaponEffectPillAbstract) {
        let original = original as! Self
        self.effectsDescription = original.effectsDescription
        self.conversionFraction = original.conversionFraction
        
        super.init(original)
        
        AfterActorTakeDamagePublisher.subscribe(self)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case effectsDescription
        case conversionFraction
    }

    required init(dataObject: DataObject) {
        self.effectsDescription = dataObject.get(Field.effectsDescription.rawValue)
        self.conversionFraction = dataObject.get(Field.conversionFraction.rawValue)
        
        super.init(dataObject: dataObject)
        
        AfterActorTakeDamagePublisher.subscribe(self)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.effectsDescription.rawValue, value: self.effectsDescription)
            .add(key: Field.conversionFraction.rawValue, value: self.conversionFraction)
    }

    // MARK: - Functions
    
    func afterActorTakeDamage(actor: ActorAbstract, damageTaken: Int) {
        // First we must make sure the actor is the one who owns this item
        guard actor.weapons.contains(where: { $0.hasEffectPill(self) }) else {
            return
        }
        assert(damageTaken > 0, "Damage taken cannot be negative")
        WeaponPillBox.getWeapon(from: self)?.adjustDamage(by: (Double(damageTaken)*self.conversionFraction).toRoundedInt())
    }
    
    func apply(owner: ActorAbstract, opposition: ActorAbstract) {
        // Do nothing
    }
    
    func calculateBasePurchasePrice() -> Int {
        return Pricing.playerDamageStat.getValue(
            amount: (self.conversionFraction*Double(Pricing.foeDamageStat.baseStatAmount)*Double(Pricing.Stat.infiniteDuration)).toRoundedInt()
        )
    }
    
}

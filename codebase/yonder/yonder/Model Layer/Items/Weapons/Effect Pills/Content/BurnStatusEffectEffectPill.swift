//
//  BurnStatusEffectEffectPill.swift
//  yonder
//
//  Created by Andre Pham on 23/6/2022.
//

import Foundation

class BurnStatusEffectEffectPill: WeaponEffectPill {
    
    public let effectsDescription: String
    public var previewEffectsDescription: String {
        return self.effectsDescription
    }
    public let tickDamage: Int
    private let initialDuration: Int
    
    init(tickDamage: Int, duration: Int) {
        self.effectsDescription = Strings("weaponEffectPill.burnStatusEffect.description1Param").localWithArgs(tickDamage)
        self.tickDamage = tickDamage
        self.initialDuration = duration
        super.init()
    }
    
    required init(_ original: WeaponEffectPillAbstract) {
        let original = original as! Self
        self.effectsDescription = original.effectsDescription
        self.tickDamage = original.tickDamage
        self.initialDuration = original.initialDuration
        super.init(original)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case effectsDescription
        case tickDamage
        case initialDuration
    }

    required init(dataObject: DataObject) {
        self.effectsDescription = dataObject.get(Field.effectsDescription.rawValue)
        self.tickDamage = dataObject.get(Field.tickDamage.rawValue)
        self.initialDuration = dataObject.get(Field.initialDuration.rawValue)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.effectsDescription.rawValue, value: self.effectsDescription)
            .add(key: Field.tickDamage.rawValue, value: self.tickDamage)
            .add(key: Field.initialDuration.rawValue, value: self.initialDuration)
    }

    // MARK: - Functions
    
    func apply(owner: ActorAbstract, opposition: ActorAbstract) {
        opposition.addStatusEffect(BurnStatusEffect(damage: self.tickDamage, duration: self.initialDuration))
    }
    
    func calculateBasePurchasePrice() -> Int {
        return (Double(Pricing.playerDamageStat.getValue(amount: self.tickDamage)*self.initialDuration)).toRoundedInt()
    }
    
}

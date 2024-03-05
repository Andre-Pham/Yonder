//
//  GrowDamageAfterTravelEffectPill.swift
//  yonder
//
//  Created by Andre Pham on 6/3/2024.
//

import Foundation

class GrowDamageAfterTravelEffectPill: WeaponEffectPill, AfterPlayerTravelSubscriber {
    
    public let effectsDescription: String
    public let damageIncrease: Int
    
    init(damageIncrease: Int) {
        self.effectsDescription = Strings("weaponEffectPill.growDamageAfterTravel.description1Param").localWithArgs(damageIncrease)
        self.damageIncrease = damageIncrease
        super.init()
        
        AfterPlayerTravelPublisher.subscribe(self)
    }
    
    required init(_ original: WeaponEffectPillAbstract) {
        let original = original as! Self
        self.effectsDescription = original.effectsDescription
        self.damageIncrease = original.damageIncrease
        super.init(original)
        
        AfterPlayerTravelPublisher.subscribe(self)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case effectsDescription
        case damageIncrease
    }

    required init(dataObject: DataObject) {
        self.effectsDescription = dataObject.get(Field.effectsDescription.rawValue)
        self.damageIncrease = dataObject.get(Field.damageIncrease.rawValue)
        super.init(dataObject: dataObject)
        
        AfterPlayerTravelPublisher.subscribe(self)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.effectsDescription.rawValue, value: self.effectsDescription)
            .add(key: Field.damageIncrease.rawValue, value: self.damageIncrease)
    }

    // MARK: - Functions
    
    func apply(owner: ActorAbstract, opposition: ActorAbstract) {
        // Do nothing
    }
    
    func calculateBasePurchasePrice() -> Int {
        return Pricing.playerDamageStat.getValue(amount: self.damageIncrease)*Pricing.Stat.infiniteDuration
    }
    
    func afterPlayerTravel(player: Player) {
        if player.weapons.contains(where: { $0.hasEffectPill(self) }) {
            WeaponPillBox.getWeapon(from: self)?.adjustDamage(by: self.damageIncrease)
        }
    }
    
}

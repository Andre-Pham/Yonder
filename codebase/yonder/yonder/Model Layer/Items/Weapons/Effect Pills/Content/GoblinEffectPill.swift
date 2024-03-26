//
//  GoblinEffectPill.swift
//  yonder
//
//  Created by Andre Pham on 17/9/2022.
//

import Foundation

class GoblinEffectPill: WeaponEffectPill, OnGoldChangeSubscriber, OnPlayerTravelSubscriber {
    
    public let goldPerSteal: Int
    private let damage: Int
    public let effectsDescription: String
    public var previewEffectsDescription: String {
        return self.effectsDescription
    }
    
    init(goldPerSteal: Int, damage: Int) {
        self.goldPerSteal = goldPerSteal
        self.damage = damage
        self.effectsDescription = Strings("weaponEffectPill.goblin.description2Param").localWithArgs(self.goldPerSteal, self.damage)
        super.init()
        
        OnGoldChangePublisher.subscribe(self)
        OnPlayerTravelPublisher.subscribe(self) // For if the player has never received any gold
    }
    
    required init(_ original: WeaponEffectPillAbstract) {
        let original = original as! Self
        self.goldPerSteal = original.goldPerSteal
        self.damage = original.damage
        self.effectsDescription = original.effectsDescription
        super.init(original)
        
        OnGoldChangePublisher.subscribe(self)
        OnPlayerTravelPublisher.subscribe(self)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case goldPerSteal
        case damage
        case effectsDescription
    }

    required init(dataObject: DataObject) {
        self.goldPerSteal = dataObject.get(Field.goldPerSteal.rawValue)
        self.damage = dataObject.get(Field.damage.rawValue)
        self.effectsDescription = dataObject.get(Field.effectsDescription.rawValue)
        super.init(dataObject: dataObject)
        
        OnGoldChangePublisher.subscribe(self)
        OnPlayerTravelPublisher.subscribe(self)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.goldPerSteal.rawValue, value: self.goldPerSteal)
            .add(key: Field.damage.rawValue, value: self.damage)
            .add(key: Field.effectsDescription.rawValue, value: self.effectsDescription)
    }

    // MARK: - Functions
    
    func apply(owner: ActorAbstract, opposition: ActorAbstract) {
        if let player = opposition as? Player {
            if player.gold > 0 {
                player.modifyGoldAdjusted(by: -self.goldPerSteal)
            }
        } else {
            assertionFailure("GoblinEffectPill is being used on a non-player, and only players have gold to steal")
        }
    }
    
    func onGoldChange(player: Player) {
        if let weapon = WeaponPillBox.getWeapon(from: self) {
            if player.gold > 0 {
                weapon.setDamage(to: 0)
            } else {
                weapon.setDamage(to: self.damage)
            }
        }
    }
    
    func onPlayerTravel(player: Player, newLocation: Location) {
        self.onGoldChange(player: player)
    }
    
    func calculateBasePurchasePrice() -> Int {
        assertionFailure("GoblinEffectPill is being used on a non-player, and only players have gold to steal")
        return 0
    }
    
}

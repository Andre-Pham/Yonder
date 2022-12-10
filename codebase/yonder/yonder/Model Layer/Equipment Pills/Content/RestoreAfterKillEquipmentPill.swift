//
//  RestoreAfterKillEquipmentPill.swift
//  yonder
//
//  Created by Andre Pham on 17/11/2022.
//

import Foundation

class RestoreAfterKillEquipmentPill: EquipmentPill, AfterPlayerKillFoeSubscriber {
    
    private let healthRestoration: Int
    private let armorPointsRestoration: Int
    
    init(healthRestoration: Int, armorPointsRestoration: Int, sourceName: String) {
        self.healthRestoration = healthRestoration
        self.armorPointsRestoration = armorPointsRestoration
        
        let effectsDescription: String
        if healthRestoration == 0 && armorPointsRestoration > 0 {
            effectsDescription = Strings("equipmentPill.restoreAfterKill.armorPoints.effectsDescription1Param").localWithArgs(armorPointsRestoration)
        } else if healthRestoration > 0 && armorPointsRestoration == 0 {
            effectsDescription = Strings("equipmentPill.restoreAfterKill.health.effectsDescription1Param").localWithArgs(healthRestoration)
        } else if healthRestoration > 0 && armorPointsRestoration > 0 {
            effectsDescription = Strings("equipmentPill.restoreAfterKill.healthAndArmorPoints.effectsDescription2Param").localWithArgs(healthRestoration, armorPointsRestoration)
        } else {
            effectsDescription = ""
            assertionFailure("Accessory has invalid params, both params must be >= 0 and one must be > 0.")
        }
        super.init(
            sourceName: sourceName,
            effectsDescription: effectsDescription
        )
        
        AfterPlayerKillFoePublisher.subscribe(self)
    }
    
    required init(_ original: EquipmentPillAbstract) {
        let original = original as! Self
        self.healthRestoration = original.healthRestoration
        self.armorPointsRestoration = original.armorPointsRestoration
        super.init(original)
        
        AfterPlayerKillFoePublisher.subscribe(self)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case healthRestoration
        case armorPointsRestoration
    }

    required init(dataObject: DataObject) {
        self.healthRestoration = dataObject.get(Field.healthRestoration.rawValue)
        self.armorPointsRestoration = dataObject.get(Field.armorPointsRestoration.rawValue)
        super.init(dataObject: dataObject)
        
        AfterPlayerKillFoePublisher.subscribe(self)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.healthRestoration.rawValue, value: self.healthRestoration)
            .add(key: Field.armorPointsRestoration.rawValue, value: self.armorPointsRestoration)
    }

    // MARK: - Functions
    
    func afterPlayerKillFoe(player: Player, foe: Foe) {
        assert(foe.isDead, "Event indicating that a foe died has failed - foe remains alive")
        if player.hasEquipmentEffect(self) {
            if self.healthRestoration > 0 {
                player.restoreHealthAdjusted(sourceOwner: player, using: self, for: self.healthRestoration)
            }
            if self.armorPointsRestoration > 0 {
                player.restoreArmorPointsAdjusted(sourceOwner: player, using: self, for: self.armorPointsRestoration)
            }
        }
        // If a foe has this, its effect is redundant because the player dies
    }
    
    func getValue(whenTargeting target: Target) -> Int {
        switch target {
        case .player:
            return Pricing.playerHealthRestorationStat.getValue(amount: self.healthRestoration, uses: Pricing.Stat.infiniteDuration) + Pricing.playerArmorPointsRestorationStat.getValue(amount: self.armorPointsRestoration, uses: Pricing.Stat.infiniteDuration)
        case .foe:
            return 0
            // If a foe has this, its effect is redundant because the player dies
        }
    }
    
}


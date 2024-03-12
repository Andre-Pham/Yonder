//
//  AccessoryFactory.swift
//  yonder
//
//  Created by Andre Pham on 10/11/2022.
//

import Foundation

class AccessoryFactory: BuildTokenFactory, RegionBasedFactory {
    
    enum BuildToken: String {
        case resistanceAccessory
        case reduceDamageAccessory
        case weaponLifestealAccessory
        case bonusHitPointsAccessory
        case phoenixAccessory
        case tankAccessory
        case damageBuffAccessory
        case bonusDamageAccessory
        case healthRestorationBuffAccessory
        case bonusHealthRestorationAccessory
        case armorPointsRestorationBuffAccessory
        case bonusArmorPointsRestorationAccessory
        case thornsAccessory
        case priceBuffAccessory
        case reducedPriceAccessory
        case goldBuffAccessory
        case bonusGoldAccessory
        case loseArmorGainHealthAccessory
        case restoreAfterKillEquipmentPill
        case restoreAfterTravelEquipmentPill
        case stealPermanentHealthAfterKillEquipmentPill
    }
    
    private let stage: Int
    private let regionTags: RegionTagAllocation
    private let accessoryProfileBucket: AccessoryProfileBucket
    public var buildTokenQueue = [BuildToken]()
    
    init(stage: Int, regionTags: RegionTagAllocation, profileBucket: AccessoryProfileBucket) {
        self.stage = stage
        self.regionTags = regionTags
        self.accessoryProfileBucket = profileBucket
    }
    
    private func replenishTokens() {
        var newTokens = [BuildToken]()
        // This means you can only get max of 3 weapon lifesteal accessories, etc., in a row
        newTokens.populate(count: 10, { .resistanceAccessory })
        newTokens.populate(count: 10, { .reduceDamageAccessory })
        newTokens.populate(count: 3, { .weaponLifestealAccessory })
        newTokens.populate(count: 8, { .bonusHitPointsAccessory })
        newTokens.populate(count: 3, { .phoenixAccessory })
        newTokens.populate(count: 5, { .tankAccessory })
        newTokens.populate(count: 8, { .damageBuffAccessory })
        newTokens.populate(count: 8, { .bonusDamageAccessory })
        newTokens.populate(count: 8, { .healthRestorationBuffAccessory })
        newTokens.populate(count: 8, { .bonusHealthRestorationAccessory })
        newTokens.populate(count: 8, { .armorPointsRestorationBuffAccessory })
        newTokens.populate(count: 8, { .bonusArmorPointsRestorationAccessory })
        newTokens.populate(count: 5, { .thornsAccessory })
        newTokens.populate(count: 5, { .priceBuffAccessory })
        newTokens.populate(count: 5, { .reducedPriceAccessory })
        newTokens.populate(count: 5, { .goldBuffAccessory })
        newTokens.populate(count: 5, { .bonusGoldAccessory })
        newTokens.populate(count: 3, { .loseArmorGainHealthAccessory })
        newTokens.populate(count: 3, { .restoreAfterKillEquipmentPill })
        newTokens.populate(count: 5, { .restoreAfterTravelEquipmentPill })
        newTokens.populate(count: 3, { .stealPermanentHealthAfterKillEquipmentPill })
        newTokens.shuffle()
        self.buildTokenQueue.appendToFront(contentsOf: newTokens)
    }
    
    private func createAccessory() -> Accessory {
        if self.buildTokenQueue.isEmpty {
            self.replenishTokens()
        }
        let token = self.buildTokenQueue.popLast()!
        switch token {
        case .resistanceAccessory:
            return self.createAccessoryWithSpecs(method: Accessories.resistanceAccessory, tag: .defensive)
        case .reduceDamageAccessory:
            return self.createAccessoryWithSpecs(method: Accessories.reduceDamageAccessory, tag: .defensive)
        case .weaponLifestealAccessory:
            return self.createAccessoryWithSpecs(method: Accessories.weaponLifestealAccessory, tag: .health)
        case .bonusHitPointsAccessory:
            return self.createAccessoryWithSpecs(method: Accessories.bonusHitPointsAccessory, tag: .defensive)
        case .phoenixAccessory:
            return self.createAccessoryWithSpecs(method: Accessories.phoenixAccessory, tag: .special)
        case .tankAccessory:
            return self.createAccessoryWithSpecs(method: Accessories.tankAccessory, tag: .defensive)
        case .damageBuffAccessory:
            return self.createAccessoryWithSpecs(method: Accessories.damageBuffAccessory, tag: .offensive)
        case .bonusDamageAccessory:
            return self.createAccessoryWithSpecs(method: Accessories.bonusDamageAccessory, tag: .offensive)
        case .healthRestorationBuffAccessory:
            return self.createAccessoryWithSpecs(method: Accessories.healthRestorationBuffAccessory, tag: .health)
        case .bonusHealthRestorationAccessory:
            return self.createAccessoryWithSpecs(method: Accessories.bonusHealthRestorationAccessory, tag: .health)
        case .armorPointsRestorationBuffAccessory:
            return self.createAccessoryWithSpecs(method: Accessories.armorPointsRestorationBuffAccessory, tag: .defensive)
        case .bonusArmorPointsRestorationAccessory:
            return self.createAccessoryWithSpecs(method: Accessories.bonusArmorPointsRestorationAccessory, tag: .defensive)
        case .thornsAccessory:
            return self.createAccessoryWithSpecs(method: Accessories.thornsAccessory, tag: .offensive)
        case .priceBuffAccessory:
            return self.createAccessoryWithSpecs(method: Accessories.priceBuffAccessory, tag: .gold)
        case .reducedPriceAccessory:
            return self.createAccessoryWithSpecs(method: Accessories.reducedPriceAccessory, tag: .gold)
        case .goldBuffAccessory:
            return self.createAccessoryWithSpecs(method: Accessories.goldBuffAccessory, tag: .gold)
        case .bonusGoldAccessory:
            return self.createAccessoryWithSpecs(method: Accessories.bonusGoldAccessory, tag: .gold)
        case .loseArmorGainHealthAccessory:
            return self.createAccessoryWithSpecs(method: Accessories.loseArmorGainHealthAccessory, tag: .special)
        case .restoreAfterKillEquipmentPill:
            return self.createAccessoryWithSpecs(method: Accessories.restoreAfterKillEquipmentPill, tag: .special)
        case .restoreAfterTravelEquipmentPill:
            return self.createAccessoryWithSpecs(method: Accessories.restoreAfterTravelEquipmentPill, tag: .health)
        case .stealPermanentHealthAfterKillEquipmentPill:
            return self.createAccessoryWithSpecs(method: Accessories.stealPermanentHealthAfterKillEquipmentPill, tag: .health)
        }
    }
    
    private func createAccessoryWithSpecs(
        method: (_ profile: AccessoryProfile, _ stage: Int, _ type: AccessoryType) -> Accessory,
        tag: AccessoryProfileTag
    ) -> Accessory {
        // Make it a 1 in 5 to get a peripheral accessory, which matches with the accessory slot ratios
        let accessoryType: AccessoryType = (Random.roll(1, in: 5) ? .peripheral : .regular)
        let profile = self.accessoryProfileBucket.grabProfile(
            areaTag: self.regionTags.getTag(),
            accessoryTag: tag,
            accessoryType: accessoryType
        )
        return method(profile, self.stage, accessoryType)
    }
    
    func deliver() -> Accessory {
        return self.createAccessory()
    }
    
    func deliver(count: Int) -> [Accessory] {
        return Array(count: count, populateWith: self.createAccessory())
    }
    
    func deliverRegionTag() -> RegionProfileTag {
        return self.regionTags.getTag()
    }
    
}

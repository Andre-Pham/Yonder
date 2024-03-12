//
//  ArmorFactory.swift
//  yonder
//
//  Created by Andre Pham on 8/11/2022.
//

import Foundation

class ArmorFactory: BuildTokenFactory, RegionBasedFactory {
    
    enum BuildToken: String {
        case regularArmor
        case damagePercentArmor
        case highDamagePercentArmor
        case damageArmor
        case highDamageArmor
        case resistanceArmor
        case highResistanceArmor
        case damageNegationArmor
        case highDamageNegationArmor
        case thornsArmor
        case restorationPercentArmor
        case thornsAndResistanceArmor
        case bitOfEverythingArmor
        case phoenixArmor
        case alchemistArmor
        case bladeMasterArmor
    }
    
    private let stage: Int
    private let regionTags: RegionTagAllocation
    private let armorProfileBucket: ArmorProfileBucket
    public var buildTokenQueue = [BuildToken]()
    
    init(stage: Int, regionTags: RegionTagAllocation, profileBucket: ArmorProfileBucket) {
        self.stage = stage
        self.regionTags = regionTags
        self.armorProfileBucket = profileBucket
    }
    
    private func replenishTokens() {
        var newTokens = [BuildToken]()
        // This means you can only get max of 3 of a certain armor in a row
        newTokens.populate(count: 25, { .regularArmor })
        newTokens.populate(count: 4, { .damagePercentArmor })
        newTokens.populate(count: 4, { .highDamagePercentArmor })
        newTokens.populate(count: 4, { .damageArmor })
        newTokens.populate(count: 4, { .highDamageArmor })
        newTokens.populate(count: 4, { .resistanceArmor })
        newTokens.populate(count: 4, { .highResistanceArmor })
        newTokens.populate(count: 4, { .damageNegationArmor })
        newTokens.populate(count: 4, { .highDamageNegationArmor })
        newTokens.populate(count: 4, { .thornsArmor })
        newTokens.populate(count: 4, { .restorationPercentArmor })
        newTokens.populate(count: 4, { .thornsAndResistanceArmor })
        newTokens.populate(count: 2, { .bitOfEverythingArmor })
        newTokens.populate(count: 2, { .phoenixArmor })
        newTokens.populate(count: 2, { .alchemistArmor })
        newTokens.populate(count: 2, { .bladeMasterArmor })
        newTokens.shuffle()
        self.buildTokenQueue.appendToFront(contentsOf: newTokens)
    }
    
    private func createArmor() -> Armor {
        if self.buildTokenQueue.isEmpty {
            self.replenishTokens()
        }
        let token = self.buildTokenQueue.popLast()!
        switch token {
        case .regularArmor:
            return self.createArmorWithSpecs(method: Armors.regularArmor, tag: .heavyweight)
        case .damagePercentArmor:
            return self.createArmorWithSpecs(method: Armors.damagePercentArmor, tag: .lightweight)
        case .highDamagePercentArmor:
            return self.createArmorWithSpecs(method: Armors.highDamagePercentArmor, tag: .lightweight)
        case .damageArmor:
            return self.createArmorWithSpecs(method: Armors.damageArmor, tag: .lightweight)
        case .highDamageArmor:
            return self.createArmorWithSpecs(method: Armors.highDamageArmor, tag: .lightweight)
        case .resistanceArmor:
            return self.createArmorWithSpecs(method: Armors.resistanceArmor, tag: .heavyweight)
        case .highResistanceArmor:
            return self.createArmorWithSpecs(method: Armors.highResistanceArmor, tag: .heavyweight)
        case .damageNegationArmor:
            return self.createArmorWithSpecs(method: Armors.damageNegationArmor, tag: .heavyweight)
        case .highDamageNegationArmor:
            return self.createArmorWithSpecs(method: Armors.highDamageNegationArmor, tag: .heavyweight)
        case .thornsArmor:
            return self.createArmorWithSpecs(method: Armors.thornsArmor, tag: .heavyweight)
        case .restorationPercentArmor:
            return self.createArmorWithSpecs(method: Armors.restorationPercentArmor, tag: .heavyweight)
        case .thornsAndResistanceArmor:
            return self.createArmorWithSpecs(method: Armors.thornsAndResistanceArmor, tag: .heavyweight)
        case .bitOfEverythingArmor:
            return self.createArmorWithSpecs(method: Armors.bitOfEverythingArmor, tag: .lightweight)
        case .phoenixArmor:
            return self.createArmorWithSpecs(method: Armors.phoenixArmor, tag: .heavyweight)
        case .alchemistArmor:
            return self.createArmorWithSpecs(method: Armors.alchemistArmor, tag: .lightweight)
        case .bladeMasterArmor:
            return self.createArmorWithSpecs(method: Armors.bladeMasterArmor, tag: .lightweight)
        }
    }
    
    private func createArmorWithSpecs(
        method: (_ profile: ArmorProfile, _ stage: Int, _ type: ArmorType) -> Armor,
        tag: ArmorProfileTag
    ) -> Armor {
        // Just select a random armor type (head/body/legs)
        // If it ever feels unbalanced (too many helmets in a row, etc.) this would have to be changed
        let armorType = ArmorType.allCases.randomElement()!
        let profile = self.armorProfileBucket.grabProfile(
            areaTag: self.regionTags.getTag(),
            armorTag: tag,
            armorType: armorType
        )
        return method(profile, self.stage, armorType)
    }
    
    func deliver() -> Armor {
        return self.createArmor()
    }
    
    func deliver(count: Int) -> [Armor] {
        return Array(count: count, populateWith: self.createArmor())
    }
    
    func deliverRegionTag() -> RegionProfileTag {
        return self.regionTags.getTag()
    }
    
}

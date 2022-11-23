//
//  ArmorFactory.swift
//  yonder
//
//  Created by Andre Pham on 8/11/2022.
//

import Foundation

class ArmorFactory {
    
    private let stage: Int
    private let areaTags: AreaProfileTagAllocation
    private let armorProfileBucket: ArmorProfileBucket
    private var armorSupply = [Armor]()
    
    init(stage: Int, areaTags: AreaProfileTagAllocation, profileBucket: ArmorProfileBucket) {
        self.stage = stage
        self.areaTags = areaTags
        self.armorProfileBucket = profileBucket
    }
    
    private func buildArmors() {
        var armors = [Armor]()
        
        // 01
        self.addArmor(to: &armors, method: Armors.regularArmor, count: 25, tag: .heavyweight)
        // 02
        self.addArmor(to: &armors, method: Armors.damagePercentArmor, count: 4, tag: .lightweight)
        // 03
        self.addArmor(to: &armors, method: Armors.highDamagePercentArmor, count: 4, tag: .lightweight)
        // 04
        self.addArmor(to: &armors, method: Armors.damageArmor, count: 4, tag: .lightweight)
        // 05
        self.addArmor(to: &armors, method: Armors.highDamageArmor, count: 4, tag: .lightweight)
        // 06
        self.addArmor(to: &armors, method: Armors.resistanceArmor, count: 4, tag: .heavyweight)
        // 07
        self.addArmor(to: &armors, method: Armors.highResistanceArmor, count: 4, tag: .heavyweight)
        // 08
        self.addArmor(to: &armors, method: Armors.damageNegationArmor, count: 4, tag: .heavyweight)
        // 09
        self.addArmor(to: &armors, method: Armors.highDamageNegationArmor, count: 4, tag: .heavyweight)
        // 10
        self.addArmor(to: &armors, method: Armors.thornsArmor, count: 4, tag: .heavyweight)
        // 11
        self.addArmor(to: &armors, method: Armors.restorationPercentArmor, count: 4, tag: .heavyweight)
        // 12
        self.addArmor(to: &armors, method: Armors.thornsAndResistanceArmor, count: 4, tag: .heavyweight)
        // 13
        self.addArmor(to: &armors, method: Armors.bitOfEverythingArmor, count: 2, tag: .lightweight)
        // 14
        self.addArmor(to: &armors, method: Armors.phoenixArmor, count: 2, tag: .heavyweight)
        // 15
        self.addArmor(to: &armors, method: Armors.alchemistArmor, count: 2, tag: .lightweight)
        // 16
        self.addArmor(to: &armors, method: Armors.bladeMasterArmor, count: 2, tag: .lightweight)
        
        armors.shuffle()
        self.armorSupply.append(contentsOf: armors)
    }
    
    private func addArmor(
        to armors: inout [Armor],
        method: (_ profile: ArmorProfile, _ stage: Int, _ type: ArmorType) -> Armor,
        count: Int,
        tag: ArmorProfileTag
    ) {
        let allTypes = ArmorType.allCases
        var typeIndex = Int.random(in: 0..<allTypes.count)
        armors.populate(count: count) {
            let armorType = allTypes[typeIndex]
            typeIndex += 1
            return method(
                self.armorProfileBucket.grabProfile(areaTag: self.areaTags.getTag(), armorTag: tag, armorType: armorType),
                self.stage,
                armorType
            )
        }
    }
    
    func deliver() -> Armor {
        if self.armorSupply.isEmpty {
            self.buildArmors()
        }
        return self.armorSupply.popLast()!
    }
    
    func deliver(count: Int) -> [Armor] {
        if self.armorSupply.count < count {
            self.buildArmors()
        }
        return self.armorSupply.dropLast(count)
    }
    
}

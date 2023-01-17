//
//  ArmorFactory.swift
//  yonder
//
//  Created by Andre Pham on 8/11/2022.
//

import Foundation

class ArmorFactory {
    
    private let stage: Int
    private let regionTags: RegionTagAllocation
    private let armorProfileBucket: ArmorProfileBucket
    private var armorSupply = [Armor]()
    private var profilesInUse = [UUID: ArmorProfile]()
    
    init(stage: Int, regionTags: RegionTagAllocation, profileBucket: ArmorProfileBucket) {
        self.stage = stage
        self.regionTags = regionTags
        self.armorProfileBucket = profileBucket
    }
    
    func recycleProfiles() {
        for profile in self.profilesInUse.values {
            self.armorProfileBucket.restoreProfile(profile)
        }
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
        self.armorSupply.appendToFront(contentsOf: armors)
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
            typeIndex = (typeIndex + 1)%allTypes.count
            let profile = self.armorProfileBucket.grabProfile(areaTag: self.regionTags.getTag(), armorTag: tag, armorType: armorType)
            let armor = method(profile, self.stage, armorType)
            self.profilesInUse[armor.id] = profile
            return armor
        }
    }
    
    func deliver() -> Armor {
        if self.armorSupply.isEmpty {
            self.buildArmors()
        }
        let armor = self.armorSupply.popLast()!
        self.profilesInUse.removeValue(forKey: armor.id)
        return armor
    }
    
    func deliver(count: Int) -> [Armor] {
        let initialCount = self.armorSupply.count
        while self.armorSupply.count < count {
            self.buildArmors()
            assert(initialCount < self.armorSupply.count, "No armors being generated - infinite loop")
        }
        let armors = self.armorSupply.takeLast(count)
        armors.forEach({ self.profilesInUse.removeValue(forKey: $0.id) })
        return armors
    }
    
}

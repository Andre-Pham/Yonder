//
//  AccessoryFactory.swift
//  yonder
//
//  Created by Andre Pham on 10/11/2022.
//

import Foundation

class AccessoryFactory {
    
    private let stage: Int
    private let areaTags: AreaProfileTagAllocation
    private let accessoryProfileBucket: AccessoryProfileBucket
    private var accessorySupply = [Accessory]()
    
    init(stage: Int, areaTags: AreaProfileTagAllocation, profileBucket: AccessoryProfileBucket) {
        self.stage = stage
        self.areaTags = areaTags
        self.accessoryProfileBucket = profileBucket
    }
    
    private func buildAccessories() {
        var accessories = [Accessory]()
        
        // 01
        self.addAccessory(
            to: &accessories,
            method: Accessories.resistanceAccessory,
            count: 10,
            tag: .defensive
        )
        // 02
        self.addAccessory(
            to: &accessories,
            method: Accessories.reduceDamageAccessory,
            count: 10,
            tag: .defensive
        )
        // 03
        self.addAccessory(
            to: &accessories,
            method: Accessories.weaponLifestealAccessory,
            count: 3,
            tag: .health
        )
        // 04
        self.addAccessory(
            to: &accessories,
            method: Accessories.bonusHitPointsAccessory,
            count: 8,
            tag: .defensive
        )
        // 05
        self.addAccessory(
            to: &accessories,
            method: Accessories.phoenixAccessory,
            count: 3,
            tag: .special
        )
        // 06
        self.addAccessory(
            to: &accessories,
            method: Accessories.tankAccessory,
            count: 5,
            tag: .defensive
        )
        // 07
        self.addAccessory(
            to: &accessories,
            method: Accessories.damageBuffAccessory,
            count: 8,
            tag: .offensive
        )
        // 08
        self.addAccessory(
            to: &accessories,
            method: Accessories.bonusDamageAccessory,
            count: 8,
            tag: .offensive
        )
        // 09
        self.addAccessory(
            to: &accessories,
            method: Accessories.healthRestorationBuffAccessory,
            count: 8,
            tag: .health
        )
        // 10
        self.addAccessory(
            to: &accessories,
            method: Accessories.bonusHealthRestorationAccessory,
            count: 8,
            tag: .health
        )
        // 11
        self.addAccessory(
            to: &accessories,
            method: Accessories.armorPointsRestorationBuffAccessory,
            count: 8,
            tag: .defensive
        )
        // 12
        self.addAccessory(
            to: &accessories,
            method: Accessories.bonusArmorPointsRestorationAccessory,
            count: 8,
            tag: .defensive
        )
        // 13
        self.addAccessory(
            to: &accessories,
            method: Accessories.thornsAccessory,
            count: 5,
            tag: .offensive
        )
        // 14
        self.addAccessory(
            to: &accessories,
            method: Accessories.priceBuffAccessory,
            count: 5,
            tag: .gold
        )
        // 15
        self.addAccessory(
            to: &accessories,
            method: Accessories.reducedPriceAccessory,
            count: 5,
            tag: .gold
        )
        // 16
        self.addAccessory(
            to: &accessories,
            method: Accessories.goldBuffAccessory,
            count: 5,
            tag: .gold
        )
        // 17
        self.addAccessory(
            to: &accessories,
            method: Accessories.bonusGoldAccessory,
            count: 5,
            tag: .gold
        )
        // 18
        self.addAccessory(
            to: &accessories,
            method: Accessories.loseArmorGainHealthAccessory,
            count: 3,
            tag: .special
        )
        // 19
        self.addAccessory(
            to: &accessories,
            method: Accessories.restoreAfterKillEquipmentPill,
            count: 3,
            tag: .special
        )
        // 20
        self.addAccessory(
            to: &accessories,
            method: Accessories.restoreAfterTravelEquipmentPill,
            count: 5,
            tag: .health
        )
        // 21
        self.addAccessory(
            to: &accessories,
            method: Accessories.stealPermanentHealthAfterKillEquipmentPill,
            count: 3,
            tag: .health
        )
        
        accessories.shuffle()
        self.accessorySupply.appendToFront(contentsOf: accessories)
    }
    
    private func addAccessory(
        to accessories: inout [Accessory],
        method: (_ profile: AccessoryProfile, _ stage: Int, _ type: AccessoryType) -> Accessory,
        count: Int,
        tag: AccessoryProfileTag
    ) {
        accessories.populate(count: count) {
            let accessoryType: AccessoryType = (Random.roll(1, in: 5) ? .peripheral : .regular)
            return method(
                self.accessoryProfileBucket.grabProfile(
                    areaTag: self.areaTags.getTag(),
                    accessoryTag: tag,
                    accessoryType: accessoryType
                ),
                self.stage,
                accessoryType
            )
        }
    }
    
    func deliver() -> Accessory {
        if self.accessorySupply.isEmpty {
            self.buildAccessories()
        }
        return self.accessorySupply.popLast()!
    }
    
    func deliver(count: Int) -> [Accessory] {
        let initialCount = self.accessorySupply.count
        while self.accessorySupply.count < count {
            self.buildAccessories()
            assert(initialCount < self.accessorySupply.count, "No accessories being generated - infinite loop")
        }
        return self.accessorySupply.takeLast(count)
    }
    
}

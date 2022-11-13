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
    
    private func buildAccessories(stage: Int, tags: AreaProfileTagAllocation) {
        var accessories = [Accessory]()
        
        // Resistance
        accessories.populateContentsOf(count: 5) {
            self.compileAccessoryTypes() { accessoryType in
                Accessories.resistanceAccessory(
                    profile: self.accessoryProfileBucket.grabProfile(
                        areaTag: tags.getTag(),
                        accessoryTag: .defensive,
                        accessoryType: accessoryType
                    ),
                    stage: stage,
                    type: accessoryType
                )
            }
        }
        // TODO: Repeat for all remaining accessories
        
        accessories.shuffle()
        self.accessorySupply.append(contentsOf: accessories)
    }
    
    private func compileAccessoryTypes(_ callback: (_ accessoryType: AccessoryType) -> Accessory) -> [Accessory] {
        var accessories = [Accessory]()
        for type in AccessoryType.allCases {
            // For each peripheral accessory in the loot pool, there are 4 regular accessories
            switch type {
            case .regular:
                for _ in 0..<4 {
                    accessories.append(callback(.regular))
                }
            case .peripheral:
                accessories.append(callback(.peripheral))
            }
        }
        return accessories
    }
    
    func deliver() -> Accessory {
        if self.accessorySupply.isEmpty {
            self.buildAccessories(stage: self.stage, tags: self.areaTags)
        }
        return self.accessorySupply.popLast()!
    }
    
    func deliver(count: Int) -> [Accessory] {
        if self.accessorySupply.count < count {
            self.buildAccessories(stage: self.stage, tags: self.areaTags)
        }
        return self.accessorySupply.dropLast(count)
    }
    
}

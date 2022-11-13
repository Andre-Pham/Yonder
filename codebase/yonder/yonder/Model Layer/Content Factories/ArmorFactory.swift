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
    
    private func buildArmors(stage: Int, tags: AreaProfileTagAllocation) {
        var armors = [Armor]()
        
        // Regular
        armors.populateContentsOf(count: 20) {
            self.compileArmorSet() { armorType in
                Armors.regularArmor(
                    profile: self.armorProfileBucket.grabProfile(
                        areaTag: tags.getTag(),
                        armorTag: ArmorProfileTag.allCases.randomElement()!,
                        armorType: armorType
                    ),
                    stage: stage,
                    type: armorType
                )
            }
        }
        // TODO: Repeat for all remaining armors
        
        armors.shuffle()
        self.armorSupply.append(contentsOf: armors)
    }
    
    private func compileArmorSet(_ callback: (_ armorType: ArmorType) -> Armor) -> [Armor] {
        var armors = [Armor]()
        for armorType in ArmorType.allCases {
            armors.append(callback(armorType))
        }
        return armors
    }
    
    func deliver() -> Armor {
        if self.armorSupply.isEmpty {
            self.buildArmors(stage: self.stage, tags: self.areaTags)
        }
        return self.armorSupply.popLast()!
    }
    
    func deliver(count: Int) -> [Armor] {
        if self.armorSupply.count < count {
            self.buildArmors(stage: self.stage, tags: self.areaTags)
        }
        return self.armorSupply.dropLast(count)
    }
    
}

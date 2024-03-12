//
//  FriendlyFactory.swift
//  yonder
//
//  Created by Andre Pham on 13/11/2022.
//

import Foundation

class FriendlyFactory: BuildTokenFactory, RegionBasedFactory {
    
    enum BuildToken: String {
        case goldOrRestorationFriendly          // 01
        case dragonSlayerFriendly               // 02
        case healthForGoldFriendly              // 03
        case shivFriendly                       // 04
        case sellPotionsFriendly                // 05
        case maxPointsForArmorPointsFriendly    // 06
        case goldBlessingOrCurseFriendly        // 07
        case weaponDamageOrPotionCountFriendly  // 08
        case freeItemsFriendly                  // 09
    }
    
    private let stage: Int
    private let regionTags: RegionTagAllocation
    private let friendlyProfileBucket: FriendlyProfileBucket
    private let lootFactory: LootFactoryBundle
    public var buildTokenQueue = [BuildToken]()
    
    init(stage: Int, regionTags: RegionTagAllocation, friendlyProfileBucket: FriendlyProfileBucket, lootFactory: LootFactoryBundle) {
        self.stage = stage
        self.regionTags = regionTags
        self.friendlyProfileBucket = friendlyProfileBucket
        self.lootFactory = lootFactory
    }
    
    private func replenishTokens() {
        var newTokens = [BuildToken]()
        // 01
        newTokens.populate(count: 3, { .goldOrRestorationFriendly })
        // 02
        newTokens.populate(count: 1, { .dragonSlayerFriendly })
        // 03
        newTokens.populate(count: 3, { .healthForGoldFriendly })
        // 04
        newTokens.populate(count: 1, { .shivFriendly })
        // 05
        newTokens.populate(count: 2, { .sellPotionsFriendly })
        // 06
        newTokens.populate(count: 2, { .maxPointsForArmorPointsFriendly })
        // 07
        newTokens.populate(count: 2, { .goldBlessingOrCurseFriendly })
        // 08
        newTokens.populate(count: 2, { .weaponDamageOrPotionCountFriendly })
        // 09
        newTokens.populate(count: 5, { .freeItemsFriendly })
        newTokens.shuffle()
        self.buildTokenQueue.appendToFront(contentsOf: newTokens)
    }
    
    private func createFriendly() -> Friendly {
        if self.buildTokenQueue.isEmpty {
            self.replenishTokens()
        }
        let token = self.buildTokenQueue.popLast()!
        switch token {
        case .goldOrRestorationFriendly:
            return self.buildFriendly(
                method: Friendlies.goldOrRestorationFriendly,
                tag: .generous
            )
        case .dragonSlayerFriendly:
            return self.buildFriendly(
                method: Friendlies.dragonSlayerFriendly,
                tag: .shop
            )
        case .healthForGoldFriendly:
            return self.buildFriendly(
                method: Friendlies.healthForGoldFriendly,
                tag: .sacrifice
            )
        case .shivFriendly:
            return self.buildFriendly(
                method: Friendlies.shivFriendly,
                tag: .generous
            )
        case .sellPotionsFriendly:
            return self.buildFriendly(
                method: Friendlies.sellPotionsFriendly,
                tag: .trade
            )
        case .maxPointsForArmorPointsFriendly:
            return self.buildFriendly(
                method: Friendlies.maxPointsForArmorPointsFriendly,
                tag: .sacrifice
            )
        case .goldBlessingOrCurseFriendly:
            return self.buildFriendly(
                method: Friendlies.goldBlessingOrCurseFriendly,
                tag: .curse
            )
        case .weaponDamageOrPotionCountFriendly:
            return self.buildFriendly(
                method: Friendlies.weaponDamageOrPotionCountFriendly,
                tag: .generous
            )
        case .freeItemsFriendly:
            return Friendlies.freeItemsFriendly(
                profile: self.friendlyProfileBucket.grabProfile(
                    areaTag: self.regionTags.getTag(),
                    friendlyTag: .generous
                ),
                stage: self.stage,
                lootFactory: self.lootFactory
            )
        }
    }
    
    private func buildFriendly(
        method: (_ profile: FriendlyProfile, _ stage: Int) -> Friendly,
        tag: FriendlyProfileTag
    ) -> Friendly {
        return method(self.friendlyProfileBucket.grabProfile(areaTag: self.regionTags.getTag(), friendlyTag: tag), self.stage)
    }
    
    func deliver() -> Friendly {
        return self.createFriendly()
    }
    
    func deliver(count: Int) -> [Friendly] {
        return Array(count: count, populateWith: self.createFriendly())
    }
    
    func deliverRegionTag() -> RegionProfileTag {
        return self.regionTags.getTag()
    }
    
}


//
//  FriendlyFactory.swift
//  yonder
//
//  Created by Andre Pham on 13/11/2022.
//

import Foundation

class FriendlyFactory {
    
    private let stage: Int
    private let areaTags: AreaProfileTagAllocation
    private let friendlyProfileBucket: FriendlyProfileBucket
    private let lootFactory: LootFactoryBundle
    private var friendlySupply = [Friendly]()
    private var profilesInUse = [UUID: FriendlyProfile]()
    
    init(stage: Int, areaTags: AreaProfileTagAllocation, friendlyProfileBucket: FriendlyProfileBucket, lootFactory: LootFactoryBundle) {
        self.stage = stage
        self.areaTags = areaTags
        self.friendlyProfileBucket = friendlyProfileBucket
        self.lootFactory = lootFactory
    }
    
    func recycleProfiles() {
        for profile in self.profilesInUse.values {
            self.friendlyProfileBucket.restoreProfile(profile)
        }
    }
    
    private func buildFriendlies() {
        var friendlies = [Friendly]()
        
        // 01
        self.addFriendly(to: &friendlies, method: Friendlies.goldOrRestorationFriendly, count: 3, tag: .generous)
        // 02
        self.addFriendly(to: &friendlies, method: Friendlies.dragonSlayerFriendly, count: 1, tag: .shop)
        // 03
        self.addFriendly(to: &friendlies, method: Friendlies.healthForGoldFriendly, count: 3, tag: .sacrifice)
        // 04
        self.addFriendly(to: &friendlies, method: Friendlies.shivFriendly, count: 1, tag: .generous)
        // 05
        self.addFriendly(to: &friendlies, method: Friendlies.sellPotionsFriendly, count: 2, tag: .trade)
        // 06
        self.addFriendly(to: &friendlies, method: Friendlies.maxPointsForArmorPointsFriendly, count: 2, tag: .sacrifice)
        // 07
        self.addFriendly(to: &friendlies, method: Friendlies.goldBlessingOrCurseFriendly, count: 2, tag: .curse)
        // 08
        self.addFriendly(to: &friendlies, method: Friendlies.weaponDamageOrPotionCountFriendly, count: 2, tag: .generous)
        // 09
        self.addFriendly(to: &friendlies, method: Friendlies.freeItemsFriendly, count: 5, tag: .generous)
        
        friendlies.shuffle()
        self.friendlySupply.appendToFront(contentsOf: friendlies)
    }
    
    private func addFriendly(
        to friendlies: inout [Friendly],
        method: (_ profile: FriendlyProfile, _ stage: Int) -> Friendly,
        count: Int,
        tag: FriendlyProfileTag
    ) {
        friendlies.populate(count: count) {
            method(self.friendlyProfileBucket.grabProfile(areaTag: self.areaTags.getTag(), friendlyTag: tag), self.stage)
        }
    }
    
    private func addFriendly(
        to friendlies: inout [Friendly],
        method: (_ profile: FriendlyProfile, _ stage: Int, _ lootFactory: LootFactoryBundle) -> Friendly,
        count: Int,
        tag: FriendlyProfileTag
    ) {
        friendlies.populate(count: count) {
            let profile = self.friendlyProfileBucket.grabProfile(areaTag: self.areaTags.getTag(), friendlyTag: tag)
            let friendly = method(profile, self.stage, self.lootFactory)
            self.profilesInUse[friendly.id] = profile
            return friendly
        }
    }
    
    func deliver() -> Friendly {
        if self.friendlySupply.isEmpty {
            self.buildFriendlies()
        }
        let friendly = self.friendlySupply.popLast()!
        self.profilesInUse.removeValue(forKey: friendly.id)
        return friendly
    }
    
    func deliver(count: Int) -> [Friendly] {
        let initialCount = self.friendlySupply.count
        while self.friendlySupply.count < count {
            self.buildFriendlies()
            assert(initialCount < self.friendlySupply.count, "No friendlies being generated - infinite loop")
        }
        let friendlies = self.friendlySupply.takeLast(count)
        friendlies.forEach({ self.profilesInUse.removeValue(forKey: $0.id) })
        return friendlies
    }
    
}


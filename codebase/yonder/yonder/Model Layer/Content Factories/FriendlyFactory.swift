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
    
    init(stage: Int, areaTags: AreaProfileTagAllocation, friendlyProfileBucket: FriendlyProfileBucket, lootFactory: LootFactoryBundle) {
        self.stage = stage
        self.areaTags = areaTags
        self.friendlyProfileBucket = friendlyProfileBucket
        self.lootFactory = lootFactory
    }
    
    private func buildFriendlies(stage: Int, tags: AreaProfileTagAllocation) {
        var friendlies = [Friendly]()
        
        friendlies.populate(count: 5) {
            Friendlies.newGoldOrRestorationFriendly(profile: self.friendlyProfileBucket.grabProfile(areaTag: tags.getTag(), friendlyTag: .generous), stage: stage)
        }
        // TODO: Repeat for all friendlies
        
        friendlies.shuffle()
        self.friendlySupply.append(contentsOf: friendlies)
    }
    
    func deliver() -> Friendly {
        if self.friendlySupply.isEmpty {
            self.buildFriendlies(stage: self.stage, tags: self.areaTags)
        }
        return self.friendlySupply.popLast()!
    }
    
    func deliver(count: Int) -> [Friendly] {
        if self.friendlySupply.count < count {
            self.buildFriendlies(stage: self.stage, tags: self.areaTags)
        }
        return self.friendlySupply.dropLast(count)
    }
    
}


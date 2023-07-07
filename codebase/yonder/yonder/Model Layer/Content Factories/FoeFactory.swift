//
//  FoeFactory.swift
//  yonder
//
//  Created by Andre Pham on 6/11/2022.
//

import Foundation

class FoeFactory: BuildTokenFactory {
    
    enum BuildToken: String {
        case regularFoe
        case regularObtuseFoe
        case regularAcuteFoe
        case goblinFoe
        case bruteFoe
    }
    
    private let stage: Int
    private let regionTags: RegionTagAllocation
    private let foeProfileBucket: FoeProfileBucket
    private let lootOptionsFactory: LootOptionsFactory
    public var buildTokenQueue = [BuildToken]()
    
    init(stage: Int, regionTags: RegionTagAllocation, profileBucket: FoeProfileBucket, lootFactoryBundle: LootFactoryBundle) {
        self.stage = stage
        self.regionTags = regionTags
        self.foeProfileBucket = profileBucket
        self.lootOptionsFactory = LootOptionsFactory(stage: stage, lootFactories: lootFactoryBundle)
    }
    
    private func replenishTokens() {
        var newTokens = [BuildToken]()
        // This means you can only get max of 3 brutes, etc., in a row
        newTokens.populate(count: 9, { .regularFoe })
        newTokens.populate(count: 3, { .regularObtuseFoe })
        newTokens.populate(count: 3, { .regularAcuteFoe })
        newTokens.populate(count: 3, { .goblinFoe })
        newTokens.populate(count: 3, { .bruteFoe })
        newTokens.shuffle()
        self.buildTokenQueue.appendToFront(contentsOf: newTokens)
    }
    
    private func createFoe() -> Foe {
        if self.buildTokenQueue.isEmpty {
            self.replenishTokens()
        }
        let token = self.buildTokenQueue.popLast()!
        switch token {
        case .regularFoe:
            return Foes.newRegularFoe(
                profile: self.foeProfileBucket.grabProfile(areaTag: self.regionTags.getTag(), foeTag: .none),
                stage: self.stage,
                loot: self.lootOptionsFactory.deliver()
            )
        case .regularObtuseFoe:
            return Foes.newRegularObtuseFoe(
                profile: self.foeProfileBucket.grabProfile(areaTag: self.regionTags.getTag(), foeTag: .obtuse),
                stage: self.stage,
                loot: self.lootOptionsFactory.deliver()
            )
        case .regularAcuteFoe:
            return Foes.newRegularAcuteFoe(
                profile: self.foeProfileBucket.grabProfile(areaTag: self.regionTags.getTag(), foeTag: .acute),
                stage: self.stage,
                loot: self.lootOptionsFactory.deliver()
            )
        case .goblinFoe:
            return Foes.newGoblinFoe(
                profile: self.foeProfileBucket.grabProfile(areaTag: self.regionTags.getTag(), foeTag: .goblin),
                stage: self.stage,
                loot: self.lootOptionsFactory.deliver()
            )
        case .bruteFoe:
            return Foes.newBruteFoe(
                profile: self.foeProfileBucket.grabProfile(areaTag: self.regionTags.getTag(), foeTag: .brute),
                stage: self.stage,
                loot: self.lootOptionsFactory.deliver()
            )
        }
    }
    
    func deliver() -> Foe {
        return self.createFoe()
    }
    
    func deliver(count: Int) -> [Foe] {
        return Array(count: count, populateWith: self.createFoe())
    }
    
}

//
//  FoeFactory.swift
//  yonder
//
//  Created by Andre Pham on 6/11/2022.
//

import Foundation

class FoeFactory {
    
    private let stage: Int
    private let areaTags: AreaProfileTagAllocation
    private let foeProfileBucket: FoeProfileBucket
    private let lootOptionsFactory: LootOptionsFactory
    private var foeSupply = [Foe]()
    
    init(stage: Int, areaTags: AreaProfileTagAllocation, profileBucket: FoeProfileBucket, lootFactoryBundle: LootFactoryBundle) {
        self.stage = stage
        self.areaTags = areaTags
        self.foeProfileBucket = profileBucket
        self.lootOptionsFactory = LootOptionsFactory(stage: stage, lootFactories: lootFactoryBundle)
    }
    
    private func buildFoes(stage: Int, tags: AreaProfileTagAllocation) {
        var foes = [Foe]()
        
        // Regular
        foes.populate(count: 20) {
            Foes.newRegularFoe(profile: self.foeProfileBucket.grabProfile(areaTag: tags.getTag(), foeTag: .regular), stage: stage, loot: self.lootOptionsFactory.deliver())
        }
        foes.populate(count: 5) {
            Foes.newRegularTankFoe(profile: self.foeProfileBucket.grabProfile(areaTag: tags.getTag(), foeTag: .regularTank), stage: stage, loot: self.lootOptionsFactory.deliver())
        }
        // TODO: Repeat for all types of foes
        
        self.foeSupply.shuffle()
        self.foeSupply.append(contentsOf: foes)
    }
    
    func deliver() -> Foe {
        guard !self.foeSupply.isEmpty else {
            self.buildFoes(stage: self.stage, tags: self.areaTags)
        }
        return self.foeSupply.popLast()!
    }
    
    func deliver(count: Int) -> [Foe] {
        guard self.foeSupply.count >= count else {
            self.buildFoes(stage: self.stage, tags: self.areaTags)
        }
        return self.foeSupply.dropLast(count)
    }
    
}

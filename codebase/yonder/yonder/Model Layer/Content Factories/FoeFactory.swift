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
    
    private func buildFoes() {
        var foes = [Foe]()
        
        // 01
        self.addFoe(to: &foes, method: Foes.newRegularFoe, count: 20, tag: .regular)
        // 02
        self.addFoe(to: &foes, method: Foes.newRegularObtuseFoe, count: 5, tag: .regularObtuse)
        // 03
        self.addFoe(to: &foes, method: Foes.newRegularAcuteFoe, count: 5, tag: .regularAcute)
        // 04
        self.addFoe(to: &foes, method: Foes.newGoblinFoe, count: 4, tag: .goblin)
        // 05
        self.addFoe(to: &foes, method: Foes.newGoblinObtuseFoe, count: 1, tag: .goblinObtuse)
        // 06
        self.addFoe(to: &foes, method: Foes.newGoblinAcuteFoe, count: 1, tag: .goblinAcute)
        // 07
        self.addFoe(to: &foes, method: Foes.newBruteFoe, count: 6, tag: .brute)
        
        self.foeSupply.shuffle()
        self.foeSupply.appendToFront(contentsOf: foes)
    }
    
    private func addFoe(
        to foes: inout [Foe],
        method: (_ profile: FoeProfile, _ stage: Int, _ loot: LootOptions) -> Foe,
        count: Int,
        tag: FoeProfileTag
    ) {
        foes.populate(count: count) {
            method(
                self.foeProfileBucket.grabProfile(areaTag: self.areaTags.getTag(), foeTag: tag),
                self.stage,
                self.lootOptionsFactory.deliver()
            )
        }
    }
    
    func deliver() -> Foe {
        if self.foeSupply.isEmpty {
            self.buildFoes()
        }
        return self.foeSupply.popLast()!
    }
    
    func deliver(count: Int) -> [Foe] {
        let initialCount = self.foeSupply.count
        while self.foeSupply.count < count {
            self.buildFoes()
            assert(initialCount < self.foeSupply.count, "No foes being generated - infinite loop")
        }
        return self.foeSupply.takeLast(count)
    }
    
}

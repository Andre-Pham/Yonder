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
    private var profilesInUse = [UUID: FoeProfile]()
    
    init(stage: Int, areaTags: AreaProfileTagAllocation, profileBucket: FoeProfileBucket, lootFactoryBundle: LootFactoryBundle) {
        self.stage = stage
        self.areaTags = areaTags
        self.foeProfileBucket = profileBucket
        self.lootOptionsFactory = LootOptionsFactory(stage: stage, lootFactories: lootFactoryBundle)
    }
    
    func recycleProfiles() {
        for profile in self.profilesInUse.values {
            self.foeProfileBucket.restoreProfile(profile)
        }
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
        
        foes.shuffle()
        self.foeSupply.appendToFront(contentsOf: foes)
    }
    
    private func addFoe(
        to foes: inout [Foe],
        method: (_ profile: FoeProfile, _ stage: Int, _ loot: LootOptions) -> Foe,
        count: Int,
        tag: FoeProfileTag
    ) {
        foes.populate(count: count) {
            let profile = self.foeProfileBucket.grabProfile(areaTag: self.areaTags.getTag(), foeTag: tag)
            let foe = method(profile, self.stage, self.lootOptionsFactory.deliver())
            self.profilesInUse[foe.id] = profile
            return foe
        }
    }
    
    func deliver() -> Foe {
        if self.foeSupply.isEmpty {
            self.buildFoes()
        }
        let foe = self.foeSupply.popLast()!
        self.profilesInUse.removeValue(forKey: foe.id)
        return foe
    }
    
    func deliver(count: Int) -> [Foe] {
        let initialCount = self.foeSupply.count
        while self.foeSupply.count < count {
            self.buildFoes()
            assert(initialCount < self.foeSupply.count, "No foes being generated - infinite loop")
        }
        let foes = self.foeSupply.takeLast(count)
        foes.forEach({ self.profilesInUse.removeValue(forKey: $0.id) })
        return foes
    }
    
}

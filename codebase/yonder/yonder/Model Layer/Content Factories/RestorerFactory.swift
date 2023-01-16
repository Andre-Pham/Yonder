//
//  RestorerFactory.swift
//  yonder
//
//  Created by Andre Pham on 12/11/2022.
//

import Foundation

class RestorerFactory {
    
    private let stage: Int
    private let areaTags: AreaProfileTagAllocation
    private let restorerProfileBucket: RestorerProfileBucket
    private var restorerSupply = [Restorer]()
    private var profilesInUse = [UUID: RestorerProfile]()
    
    init(stage: Int, areaTags: AreaProfileTagAllocation, restorerProfileBucket: RestorerProfileBucket) {
        self.stage = stage
        self.areaTags = areaTags
        self.restorerProfileBucket = restorerProfileBucket
    }
    
    func recycleProfiles() {
        for profile in self.profilesInUse.values {
            self.restorerProfileBucket.restoreProfile(profile)
        }
    }
    
    private func buildRestorers() {
        var restorers = [Restorer]()
        
        self.addRestorer(to: &restorers, restoreOptions: [.health, .armorPoints], count: 2)
        self.addRestorer(to: &restorers, restoreOptions: [.health], count: 1)
        self.addRestorer(to: &restorers, restoreOptions: [.armorPoints], count: 1)
        
        restorers.shuffle()
        self.restorerSupply.appendToFront(contentsOf: restorers)
    }
    
    private func addRestorer(
        to restorers: inout [Restorer],
        restoreOptions: [Restorer.RestoreOption],
        count: Int
    ) {
        restorers.populate(count: count) {
            let profile = self.restorerProfileBucket.grabProfile(areaTag: self.areaTags.getTag(), restoreOptions: restoreOptions)
            let restorer = Restorers.newRestorer(profile: profile, stage: self.stage, restoreOptions: restoreOptions)
            self.profilesInUse[restorer.id] = profile
            return restorer
        }
    }
    
    func deliver() -> Restorer {
        if self.restorerSupply.isEmpty {
            self.buildRestorers()
        }
        let restorer = self.restorerSupply.popLast()!
        self.profilesInUse.removeValue(forKey: restorer.id)
        return restorer
    }
    
    func deliver(count: Int) -> [Restorer] {
        let initialCount = self.restorerSupply.count
        while self.restorerSupply.count < count {
            self.buildRestorers()
            assert(initialCount < self.restorerSupply.count, "No restorers being generated - infinite loop")
        }
        let restorers = self.restorerSupply.takeLast(count)
        restorers.forEach({ self.profilesInUse.removeValue(forKey: $0.id) })
        return restorers
    }
    
}

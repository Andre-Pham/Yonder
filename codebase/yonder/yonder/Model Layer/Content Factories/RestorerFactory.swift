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
    
    init(stage: Int, areaTags: AreaProfileTagAllocation, restorerProfileBucket: RestorerProfileBucket) {
        self.stage = stage
        self.areaTags = areaTags
        self.restorerProfileBucket = restorerProfileBucket
    }
    
    private func buildRestorers() {
        var restorers = [Restorer]()
        var restoreOptions = [Restorer.RestoreOption]()
        
        restoreOptions = [.health, .armorPoints]
        restorers.populate(count: 2) {
            let profile = self.getProfile(options: restoreOptions)
            return Restorers.newRestorer(profile: profile, stage: self.stage, restoreOptions: restoreOptions)
        }
        
        restoreOptions = [.health]
        restorers.populate(count: 1) {
            let profile = self.getProfile(options: restoreOptions)
            return Restorers.newRestorer(profile: profile, stage: self.stage, restoreOptions: restoreOptions)
        }
        
        restoreOptions = [.armorPoints]
        restorers.populate(count: 1) {
            let profile = self.getProfile(options: restoreOptions)
            return Restorers.newRestorer(profile: profile, stage: self.stage, restoreOptions: restoreOptions)
        }
        
        restorers.shuffle()
        self.restorerSupply.appendToFront(contentsOf: restorers)
    }
    
    private func getProfile(options: [Restorer.RestoreOption]) -> RestorerProfile {
        return self.restorerProfileBucket.grabProfile(areaTag: self.areaTags.getTag(), restoreOptions: options)
    }
    
    func deliver() -> Restorer {
        if self.restorerSupply.isEmpty {
            self.buildRestorers()
        }
        return self.restorerSupply.popLast()!
    }
    
    func deliver(count: Int) -> [Restorer] {
        let initialCount = self.restorerSupply.count
        while self.restorerSupply.count < count {
            self.buildRestorers()
            assert(initialCount < self.restorerSupply.count, "No restorers being generated - infinite loop")
        }
        return self.restorerSupply.takeLast(count)
    }
    
}

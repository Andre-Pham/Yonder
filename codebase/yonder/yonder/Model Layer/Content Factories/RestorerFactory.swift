//
//  RestorerFactory.swift
//  yonder
//
//  Created by Andre Pham on 12/11/2022.
//

import Foundation

class RestorerFactory {
    
    private enum BuildToken: String {
        case health
        case armorPoints
        case healthAndArmorPoints
    }
    
    private let stage: Int
    private let regionTags: RegionTagAllocation
    private let restorerProfileBucket: RestorerProfileBucket
    private var buildTokenQueue = [BuildToken]()
    
    init(stage: Int, regionTags: RegionTagAllocation, restorerProfileBucket: RestorerProfileBucket) {
        self.stage = stage
        self.regionTags = regionTags
        self.restorerProfileBucket = restorerProfileBucket
    }
    
    func exportBuildTokenCache(regionKey: String) -> BuildTokenCache {
        return BuildTokenCache(regionKey: regionKey, serialisedTokens: self.buildTokenQueue.map({ $0.rawValue }))
    }
    
    func importSerialisedTokens(_ buildTokenCache: BuildTokenCache) {
        let tokenStrings = buildTokenCache.serialisedTokens
        for tokenString in tokenStrings {
            if let restoredToken = BuildToken(rawValue: tokenString) {
                self.buildTokenQueue.append(restoredToken)
            }
        }
    }
    
    private func replenishTokens() {
        var newTokens = [BuildToken]()
        newTokens.populate(count: 4, { .healthAndArmorPoints })
        newTokens.populate(count: 1, { .health })
        newTokens.populate(count: 1, { .armorPoints })
        newTokens.shuffle()
        self.buildTokenQueue.appendToFront(contentsOf: newTokens)
    }
    
    private func createRestorer() -> Restorer {
        if self.buildTokenQueue.isEmpty {
            self.replenishTokens()
        }
        let token = self.buildTokenQueue.popLast()!
        let restoreOptions: [Restorer.RestoreOption]
        switch token {
        case .health:
            restoreOptions = [.health]
        case .armorPoints:
            restoreOptions = [.armorPoints]
        case .healthAndArmorPoints:
            restoreOptions = [.health, .armorPoints]
        }
        return Restorers.newRestorer(
            profile: self.restorerProfileBucket.grabProfile(areaTag: self.regionTags.getTag(), restoreOptions: restoreOptions),
            stage: self.stage,
            restoreOptions: restoreOptions
        )
    }
    
    func deliver() -> Restorer {
        return self.createRestorer()
    }
    
    func deliver(count: Int) -> [Restorer] {
        return Array(count: count, populateWith: self.createRestorer())
    }
    
}

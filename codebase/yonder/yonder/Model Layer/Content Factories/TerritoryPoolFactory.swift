//
//  TerritoryPoolFactory.swift
//  yonder
//
//  Created by Andre Pham on 6/11/2022.
//

import Foundation

class TerritoryPoolFactory {
    
    private let regionProfileBucket = RegionProfileBucket()
    
    func deliver(stage: Int) -> TerritoryPool {
        var areaPools = [AreaPool]()
        var tavernAreas = [TavernArea]()
        
        let areaProfiles = self.regionProfileBucket.grabProfiles(count: 2, stage: stage)
        for areaProfile in areaProfiles {
            let areaPoolFactory = AreaPoolFactory(areaProfile: areaProfile)
            areaPools.append(areaPoolFactory.deliver())
        }
        
        let tavernAreaProfile = self.regionProfileBucket.grabProfile(stage: stage)
        let tavernAreaFactory = TavernAreaFactory(areaProfile: tavernAreaProfile, stage: stage)
        tavernAreas.append(tavernAreaFactory.deliver())
        
        return TerritoryPool(
            areaPools: areaPools,
            tavernAreas: tavernAreas
        )
    }
    
    func deliver(count: Int) -> [TerritoryPool] {
        var territoryPools = [TerritoryPool]()
        for stage in 0..<count {
            territoryPools.append(self.deliver(stage: stage))
        }
        return territoryPools
    }
    
}
